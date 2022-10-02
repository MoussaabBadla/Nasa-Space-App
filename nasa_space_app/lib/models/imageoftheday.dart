import 'dart:convert';

class ImageOfTheDaY {
 final String title ; 
 final String href ; 

  ImageOfTheDaY({required this.title,required this.href}) ;
 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'href': href,
      
    };
  }

  factory ImageOfTheDaY.fromMap(Map<String, dynamic> map) {
    return ImageOfTheDaY(
      title: map['title'] as String,
      href:        map['url']  as String ,
    
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageOfTheDaY.fromJson(String source) =>
      ImageOfTheDaY.fromMap(json.decode(source) as Map<String, dynamic>);
}