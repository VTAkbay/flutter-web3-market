import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import '../models/market_item.dart';

class ItemDetailPage extends StatelessWidget {
  final MarketItem item;

  const ItemDetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.network(item.imageUrl, fit: BoxFit.cover, height: 300),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(item.name,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('\$${item.price}',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const SizedBox(height: 20),
                Text(item.description),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            try {
              if (kDebugMode) {
                print("Button pressed to sign transaction");
              }

              // showDialog(
              //   context: context,
              //   builder: (context) => AlertDialog(
              //     title: const Text("Purchase Successful"),
              //     content: Text(
              //         "${item.name} has been purchased for \$${item.price}"),
              //     actions: <Widget>[
              //       TextButton(
              //         child: const Text('OK'),
              //         onPressed: () => Navigator.of(context).pop(),
              //       ),
              //     ],
              //   ),
              // );
            } catch (e) {
              if (e is W3MServiceException && kDebugMode) {
                if (kDebugMode) {
                  print('W3MServiceException caught: ${e.message}');
                }
              } else if (kDebugMode) {
                print('Exception caught: ${e.toString()}');
              }
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Failed to complete the transaction."),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
          ),
          child: Text('Buy for \$${item.price}'),
        ),
      ),
    );
  }
}
