

import 'dart:convert';

class Content {
 final String title ; 
 final String nasa_id ; 
 final String description ; 
 final String date_created ; 
 final String href ; 
 final List<dynamic> keywords;

  Content({required this.title,required this.nasa_id,required this.description,required this.date_created,required this.href,required this.keywords}) ;
 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nasa_id':nasa_id,
      'title': title,
      'description': description,
      'date_created': date_created,
      'href': href,
      'keywords': keywords,
      
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      nasa_id: map['nasa_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      date_created:
       map['date_created']   as String ,
      href:        map['href']  as String ,
    
      keywords: List<String>.from((map['keywords'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Content.fromJson(String source) =>
      Content.fromMap(json.decode(source) as Map<String, dynamic>);
}