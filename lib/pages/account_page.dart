import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import '../providers/mock_data_provider.dart';
import '../services/wallet_service.dart';

class AccountPage extends StatefulWidget {
  final WalletService walletService;
  const AccountPage({super.key, required this.walletService});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final accountDetails = MockDataProvider.getAccountDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WalletService>(
        builder: (context, walletService, child) {
          List<Widget> children = [
            if (!walletService.isConnected) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    W3MConnectWalletButton(service: walletService.w3mService),
              ),
              const Center(child: Text("or")),
              Padding(
                padding: const EdgeInsets.only(left: 110, right: 110),
                child: ElevatedButton(
                  onPressed: () => walletService.createWallet(),
                  child: const Text('Create wallet',
                      style: TextStyle(fontSize: 18)),
                ),
              ),
            ] else ...[
              if (walletService.mnemonic != null &&
                  walletService.address != null &&
                  walletService.privateKeyHex != null) ...[
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.vpn_key,
                        color: Theme.of(context).colorScheme.secondary),
                    title: SelectableText(walletService.mnemonic!,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    subtitle: const Text("Mnemonic"),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.account_balance_wallet,
                        color: Theme.of(context).colorScheme.secondary),
                    title: Text(walletService.address!.hex,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    subtitle: const Text("Wallet Address"),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.security,
                        color: Theme.of(context).colorScheme.secondary),
                    title: SelectableText(walletService.privateKeyHex!,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    subtitle: const Text("Private Key"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: walletService.deleteWalletDetails,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Delete Wallet'),
                  ),
                ),
              ] else ...[
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://picsum.photos/200',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    'Username: ${accountDetails['username']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Name: ${accountDetails['name']}',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      W3MConnectWalletButton(service: walletService.w3mService),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: W3MAccountButton(service: walletService.w3mService),
                ),
              ]
            ]
          ];
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: children,
          );
        },
      ),
    );
  }
}
