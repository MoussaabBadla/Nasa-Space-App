import 'dart:convert';

import 'package:http/http.dart' as http;
class DataAPi {

  Future<List<dynamic>> getdata(String quiry)async{
    http.Response res = await http.get(Uri.parse('http://10.0.2.2:5000/users?query=$quiry'));
    print(res.body);
    print(jsonDecode(res.body)['data']);
    return jsonDecode(res.body)['data'];

  }
}