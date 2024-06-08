import 'package:flutter/material.dart';
import 'package:web3market/services/wallet_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import '../models/market_item.dart';
import '../providers/mock_data_provider.dart';
import '../widgets/price_tag.dart';
import 'item_detail_page.dart';

class MarketPage extends StatefulWidget {
  final WalletService walletService;
  const MarketPage({super.key, required this.walletService});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  void initState() {
    super.initState();
    widget.walletService.addListener(_updateConnectionStatus);
    _updateConnectionStatus();
  }

  @override
  void dispose() {
    widget.walletService.removeListener(_updateConnectionStatus);
    super.dispose();
  }

  void _updateConnectionStatus() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isConnected = widget.walletService.isConnected;
    List<MarketItem> items = MockDataProvider.getMarketItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Page'),
      ),
      body: isConnected ? buildItemList(items) : buildConnectWalletView(),
    );
  }

  Widget buildItemList(List<MarketItem> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.95,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ItemDetailPage(
                    item: item,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 0.0,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Image.network(item.imageUrl,
                      width: 120, height: 120, fit: BoxFit.cover),
                  Positioned(
                    left: 5,
                    bottom: 5,
                    child: PriceTag(price: item.price),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildConnectWalletView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Connect Wallet to see the market!"),
          W3MConnectWalletButton(service: widget.walletService.w3mService),
        ],
      ),
    );
  }
}
