import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_tonghop/models/user_model.dart';

class AuthService {
  static const String baseUrl = 'https://dummyjson.com/auth';

  // Hàm 1: Đăng nhập lấy Token
  Future<String?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['accessToken'];
      }
    } catch (e) {
      print('Lỗi login API: $e');
    }
    return null;
  }

  // Hàm 2: Lấy Profile bằng Token
  Future<UserModel?> getProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/me'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('Lỗi lấy Profile API: $e');
    }
    return null;
  }
}