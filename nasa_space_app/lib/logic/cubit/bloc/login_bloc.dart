import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../../repo/auth_repo.dart';
import 'authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final http.Response response = await userRepository.authenticate(
        loginData: event.loginData,
      );

      try {
        authenticationBloc.add(
          LoggedIn(
              token: jsonDecode(response.body)['token'],
              refreshtoken: jsonDecode(response.body)['refershToken'],
              data: response.body),
        );

        emit(LoginInitial());
      } catch (error) {
        emit(LoginFailure(error: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final http.Response response =
          await userRepository.registerAndAuthenticate(
        registerData: event.registerData,
      );
      try {
        authenticationBloc.add(
          LoggedIn(
              token: jsonDecode(response.body)['data']['token'][0],
              refreshtoken: jsonDecode(response.body)['data']['refershToken'],
              data: response.body),
        );
        emit(LoginInitial());
      } catch (error) {
        emit(LoginFailure(error: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  LoginState get initialState => LoginInitial();
}
