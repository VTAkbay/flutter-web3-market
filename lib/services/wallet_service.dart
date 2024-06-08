import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:convert/convert.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WalletService extends ChangeNotifier {
  late final W3MService w3mService;
  late bool _isConnected = false;
  String? _mnemonic;
  EthereumAddress? _address;
  String? _privateKeyHex;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Completer<void> _initializationCompleter = Completer<void>();

  bool get isConnected => _isConnected;
  String? get mnemonic => _mnemonic;
  EthereumAddress? get address => _address;
  String? get privateKeyHex => _privateKeyHex;

  WalletService() {
    _initializeWalletConnect().then((_) {
      loadWalletDetails(); // Ensure wallet details are loaded after connection initialization
    });
  }

  Future<void> createWallet() async {
    _mnemonic = bip39.generateMnemonic();
    var seed = bip39.mnemonicToSeed(_mnemonic!);
    var root = bip32.BIP32.fromSeed(seed);
    var child = root.derivePath("m/44'/60'/0'/0/0");
    var privateKeyHex = hex.encode(child.privateKey!);
    _privateKeyHex = privateKeyHex;

    var credentials = EthPrivateKey.fromHex(privateKeyHex);
    _address = credentials.address;

    await saveWalletDetails(_mnemonic!, _address!.hex, _privateKeyHex!);

    updateConnectionStatus(); // Make sure to update the connection status here
  }

  Future<void> saveWalletDetails(
      String mnemonic, String publicAddress, String privateKeyHex) async {
    await secureStorage.write(key: 'mnemonic', value: mnemonic);
    await secureStorage.write(key: 'publicAddress', value: publicAddress);
    await secureStorage.write(key: 'privateKey', value: privateKeyHex);
  }

  Future<void> deleteWalletDetails() async {
    await secureStorage.delete(key: 'mnemonic');
    await secureStorage.delete(key: 'publicAddress');
    await secureStorage.delete(key: 'privateKey');
    _mnemonic = null;
    _address = null;
    _privateKeyHex = null;

    updateConnectionStatus();
  }

  Future<void> loadWalletDetails() async {
    String? mnemonic = await secureStorage.read(key: 'mnemonic');
    String? publicAddress = await secureStorage.read(key: 'publicAddress');
    String? privateKeyHex = await secureStorage.read(key: 'privateKey');

    if (mnemonic != null && publicAddress != null && privateKeyHex != null) {
      _mnemonic = mnemonic;
      _privateKeyHex = privateKeyHex;
      _address = EthereumAddress.fromHex(publicAddress);
    } else {}

    updateConnectionStatus();
  }

  Future<String?> getWalletAddress() async {
    try {
      // Wait for initialization to complete
      await _initializationCompleter.future;

      // Check if there is a wallet address saved from wallet creation
      String? publicAddress = await secureStorage.read(key: 'publicAddress');
      if (publicAddress != null) {
        _address = EthereumAddress.fromHex(publicAddress);
        return _address!.hex;
      }

      // Check if WalletConnect is connected and return the address
      if (w3mService.isConnected) {
        final accounts = w3mService.session?.getAccounts();
        if (accounts != null && accounts.isNotEmpty) {
          // Strip the 'eip155:1:' prefix
          final account = accounts[0].split(':').last;
          _address = EthereumAddress.fromHex(account);
          return _address!.hex;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  void updateConnectionStatus() {
    // bool previousConnection = _isConnected;
    _isConnected = w3mService.isConnected ||
        (_mnemonic != null && _address != null && _privateKeyHex != null);

    notifyListeners();
  }

  Future<void> _initializeWalletConnect() async {
    w3mService = W3MService(
      projectId: dotenv.env['WC_PROJECT_ID'],
      metadata: const PairingMetadata(
        name: 'Web3Market',
        description: 'Web3Market',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'web3market://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await w3mService.init();
    _checkInitialConnectionState();
    _setupConnectionListeners();
    _initializationCompleter
        .complete(); // Signal that initialization is complete
  }

  Future<void> _checkInitialConnectionState() async {
    bool serviceConnected = w3mService.isConnected;
    bool walletLoaded = (await secureStorage.read(key: 'mnemonic') != null);

    _isConnected = serviceConnected || walletLoaded;
    notifyListeners();
  }

  void _setupConnectionListeners() {
    w3mService.onModalConnect.subscribe((ModalConnect? event) {
      updateConnectionStatus();
      _isConnected = true;
    });

    w3mService.onModalDisconnect.subscribe((ModalDisconnect? event) {
      updateConnectionStatus();
      _isConnected = false;
    });
  }
}
