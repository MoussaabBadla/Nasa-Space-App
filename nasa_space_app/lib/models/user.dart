// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class User {
  final String id;
  final String? token;
  final String email;
  final String username;
  final String? password;
  final List<dynamic>? favorites;
   final String? phone;
   

   User(

      {
      required this.id,
      required this.email,
      required this.username,
      required this.password,
      this.favorites,
      this.token,
      this.phone,

       
         }
        );
        

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'token': token,
      'favorite':favorites
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
     

      favorites: map['favorite'] ,
        id: map['_id'] as String,
        email: map['email'] as String,
        username: map['username'] as String,
        password: map['password'],
        phone: map['phone'] != null ? map['phone'] as String : null,
        token: map['token']);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? password,
    String? token,
    String? phone,
    List<String>? favorites,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      favorites: favorites?? this.favorites
    );
  }
}
