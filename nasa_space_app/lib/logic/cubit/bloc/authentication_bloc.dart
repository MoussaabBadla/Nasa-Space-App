import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../../models/user.dart';
import '../../../repo/auth_repo.dart';
import '../../../services/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  final Userservice userservice = Userservice();

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUninitialized()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }
  User _user = User(
    id: '',
    email: '',
    password: '',
    token: '',
    username: '',
  );

  User get user => _user;

  void setUser(String data) {
    _user = User.fromMap(jsonDecode(data)['data']);
    emit(AuthenticationAuthenticated(user: user));
  }


    
  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final String? id = await userRepository.refreshtoken();
    if (id != null) {
      try {
        Response response = await userservice.getuser(id);
        setUser(response.body);

      } catch (e) {
        print(e.toString());
        emit(AuthenticationUnauthenticated());
      }
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(
    LoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    await userRepository.persistData(event.token, event.refreshtoken);
    setUser(event.data);
    emit(AuthenticationAuthenticated(user: user));
  }

  Future<void> _onLoggedOut(
    LoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    await userRepository.deleteData();
    emit(AuthenticationUnauthenticated());
  }

  AuthenticationState get initialState => AuthenticationUninitialized();
}



