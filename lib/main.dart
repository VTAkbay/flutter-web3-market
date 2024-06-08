import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/wallet_service.dart';
import 'pages/market_page.dart';
import 'pages/account_page.dart';
import 'pages/home_page.dart';
import 'pages/messages_page.dart';
import 'services/auth_service.dart';
import 'services/item_service.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider<WalletService>(
      create: (context) => WalletService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web3 Market',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  final AuthService authService = AuthService();
  final ItemService itemService = ItemService();
  List<dynamic> items = [];

  List<Widget> get _widgetOptions {
    final walletService = Provider.of<WalletService>(context, listen: false);
    return [
      const HomePage(),
      MarketPage(walletService: walletService),
      const MessagesPage(),
      AccountPage(walletService: walletService),
    ];
  }

  @override
  void initState() {
    super.initState();
    authenticateAndFetchItems();
  }

  void authenticateAndFetchItems() async {
    try {
      final walletService = Provider.of<WalletService>(context, listen: false);
      // Get the wallet address
      final walletAddress = await walletService.getWalletAddress();
      if (walletAddress != null) {
        // Authenticate with backend and get JWT token
        final token = await authService.authenticate(walletAddress);
        if (token != null) {
          // Fetch items using the token
          final fetchedItems = await itemService.fetchItems();
          setState(() {
            items = fetchedItems;
          });
        }
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Web3 Market'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor:
            Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      ),
    );
  }
}
