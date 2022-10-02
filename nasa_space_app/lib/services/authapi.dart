import 'dart:convert';

  import 'package:http/http.dart' as http;

import '../constant.dart';
import '../models/user.dart';


class AuthenticationAPI {

  Future<http.Response> register({
    required String email,
    required String password,
    required String username,
    String? phone,
    
  }) async {
    User user = User(
      id: '',
      username: username,
      password: password,
      email: email,
      phone: phone,
      favorites: []
    );

    return await http.post(
      Uri.parse('$uri/api/auth/signup'),
      body: user.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    
  }

  Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    return await http.post(
      Uri.parse('$uri/api/auth/login'),
      body: jsonEncode({
        'email':email,
        'password':password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<http.Response> isTokenValid({required String token}) async {
    return await http.post(
        Uri.parse(
          '$uri/api/auth/token',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token
        });
  }
}
