import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../services/authapi.dart';

class UserRepository {
  final AuthenticationAPI authenticationAPI = AuthenticationAPI();
  final _secureStorage = const FlutterSecureStorage();
  Future<http.Response> registerAndAuthenticate({
    required Map<dynamic, dynamic> registerData,
  }) async {
    return await authenticationAPI.register(
        email: registerData['email'],
        password: registerData['password'],
        username: registerData['username'],
        phone: registerData['phone']);
        
  }

  Future<http.Response> authenticate({
    required Map<dynamic, dynamic> loginData,
  }) async {
    return await authenticationAPI.login(
        email: loginData['email'], password: loginData["password"]);
  }

  Future<void> deleteData() async {
    await _secureStorage.deleteAll();
  }

  Future<void> persistData(token, refreshtoken) async {
    await _secureStorage.write(key: 'x-auth-token', value: token);
    await _secureStorage.write(key: 'x-auth-refershToken', value: refreshtoken);
  }

  Future<String?> refreshtoken() async {
    final String refreshtoken =
        await _secureStorage.read(key: 'x-auth-refershToken') ?? '';
    if (refreshtoken == '') return null;
    try {
      final validationResponce = await authenticationAPI.isTokenValid(
        token: refreshtoken,
      );
      if (jsonDecode(validationResponce.body)['success'] == true) {
        await _secureStorage.write(
            key: 'x-auth-token',
            value: jsonDecode(validationResponce.body)['data']['token']);

        return jsonDecode(validationResponce.body)['data']['id'];
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

}
