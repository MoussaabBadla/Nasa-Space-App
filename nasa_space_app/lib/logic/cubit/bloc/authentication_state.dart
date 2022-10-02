part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

// un-unitialized
class AuthenticationUninitialized extends AuthenticationState {}

// authenticated
class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  const AuthenticationAuthenticated({required this.user});

    @override
  List<Object> get props => [user];

}

// un-authenticated
class AuthenticationUnauthenticated extends AuthenticationState {}

// loading
class AuthenticationLoading extends AuthenticationState {}
