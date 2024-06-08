import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  String apiUrl = "${dotenv.get('API_URL')}/auth/authenticate";
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<String?> authenticate(String walletAddress) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'walletAddress': walletAddress}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        await secureStorage.write(key: 'token', value: token);
        return token;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<void> clearToken() async {
    await secureStorage.delete(key: 'token');
  }
}
