import 'dart:convert';

import 'package:http/http.dart' as http;
class DataAPi {

  Future<dynamic> getdata(String quiry)async{
    http.Response res = await http.get(Uri.parse('https://images-api.nasa.gov/search?q=$quiry',),headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',

      },);
    return jsonDecode(res.body)['collection']['items'];

  }

    Future<dynamic> gataimageoftheday()async{
    http.Response res = await http.get(Uri.parse('https://api.nasa.gov/planetary/apod?api_key=MT2DQTWLZ0PIqGbjFB6nEhoYSO86jHxbGo0CXACo'));
    print(res.body);
    return jsonDecode(res.body);

  }

}