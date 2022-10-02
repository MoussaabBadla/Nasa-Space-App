import 'package:nasa_space_app/models/content.dart';
import 'package:nasa_space_app/services/data.dart';

import '../models/imageoftheday.dart';

class DataRepo{
 DataAPi dataAPi = DataAPi();
 

   Future<List<Content>> data(String quiry) async {
    List<dynamic> contentlist = await dataAPi.getdata(quiry);
     
    return contentlist.map((e) => Content.fromMap(e['data'],e['links'])).toList();
  }
   Future<ImageOfTheDaY> imageoftheday() async {
  dynamic contentlist = await dataAPi.gataimageoftheday();

    return ImageOfTheDaY.fromMap(contentlist);
  }

}