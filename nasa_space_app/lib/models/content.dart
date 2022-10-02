

import 'dart:convert';

class Content {
 final String? title ; 
 final String? nasa_id ; 
 final String? description ; 
 final String? date_created ; 
 final String? href ; 
 final List<dynamic>? keywords;

  Content({ this.title, this.nasa_id, this.description, this.date_created, this.href, this.keywords}) ;
 

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
  
  factory Content.fromMap( List<dynamic>? map , List<dynamic>? map2) {
    print(map);
    print(map2);
    Map<String , dynamic>?  _map = map !=null?  map[0]  : null;
    Map<String , dynamic>? _map2 = map2 !=null?  map2[0]  : null;
    return Content(
      nasa_id: _map!=null ?  _map['nasa_id']??   null : null,
      title: _map!=null ?  _map['title']?? null : null,
      description: _map!=null ?  _map['description']??  null : null ,
      date_created:
        _map!=null ?  _map['date_created']?? null  : null,
      href:        _map2!=null ?  _map2['href']?? null : null,
    
      keywords:_map!=null ? _map['keywords']!=null? List<dynamic>.from((_map['keywords'])) : null : null 
    );
  }

  String toJson() => json.encode(toMap());

}