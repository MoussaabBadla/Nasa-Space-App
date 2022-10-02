
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class Userservice {
  final _secureStorage = const FlutterSecureStorage();
  final String useruri = '$uri/api/users';
  Future<http.Response> getuser(String id) async {
    String? token = await _secureStorage.read(key: 'x-auth-token');
    return await http.get(
      Uri.parse('$useruri/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token!
      },
    );
  }

  Future<http.Response> favorite(
      {required String id, required String command}) async {
    String? token = await _secureStorage.read(key: 'x-auth-token');
    return await http.post(
      Uri.parse('$useruri/$command/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token!
      },
    );
  }

}