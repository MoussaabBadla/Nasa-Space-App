part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final Map<dynamic, dynamic> loginData;

  const LoginButtonPressed({
    required this.loginData,
  });

  @override
  List<Object?> get props => [loginData];
}

class RegisterButtonPressed extends LoginEvent {
  final Map<dynamic, dynamic> registerData;

  const RegisterButtonPressed({
    required this.registerData,
  });

  @override
  List<Object?> get props => [registerData];
}
