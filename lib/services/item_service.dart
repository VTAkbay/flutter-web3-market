import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ItemService {
  String apiUrl = "${dotenv.get('API_URL')}/items";
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<List<dynamic>> fetchItems() async {
    try {
      final token = await secureStorage.read(key: 'token');
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
