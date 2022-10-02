part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent([props = const []]) : super();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object?> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final String refreshtoken;
  final String data;

  LoggedIn( {required this.data, required this.token, required this.refreshtoken})
      : super([token,data,refreshtoken]);

  @override
  String toString() => 'LoggedIn';

  @override
  List<Object?> get props => [token, refreshtoken,data];
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object?> get props => [];
}

class UpdateUser extends AuthenticationEvent {
  final Map userData ;

 const  UpdateUser({required this.userData}); 
    @override
  String toString() => 'Update';

  @override
  List<Object?> get props =>[...userData['cart']];

}
