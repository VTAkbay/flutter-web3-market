// lib/providers/mock_data_provider.dart
import '../models/market_item.dart';

class MockDataProvider {
  static List<MarketItem> getMarketItems() {
    return [
      MarketItem(
        name: 'Car',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        price: 30,
        imageUrl:
            'https://picsum.photos/300/300?image=1080', // Specific image from Picsum
      ),
      MarketItem(
        name: 'Phone',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        price: 99,
        imageUrl:
            'https://picsum.photos/300/300?image=1069', // Specific image from Picsum
      ),
      MarketItem(
        name: 'House',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        price: 25,
        imageUrl:
            'https://picsum.photos/300/300?image=120', // Specific image from Picsum
      ),
      MarketItem(
        name: 'Car',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        price: 30,
        imageUrl:
            'https://picsum.photos/300/300?image=80', // Specific image from Picsum
      ),
      MarketItem(
        name: 'Phone',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        price: 99,
        imageUrl:
            'https://picsum.photos/300/300?image=69', // Specific image from Picsum
      ),
      MarketItem(
        name: 'House',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        price: 25,
        imageUrl:
            'https://picsum.photos/300/300?image=20', // Specific image from Picsum
      ),
    ];
  }

  static Map<String, String> getAccountDetails() {
    return {
      'username': 'VTAkbay',
      'name': 'Turab Akbay',
    };
  }
}
