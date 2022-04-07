import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/login/sign_in.dart';

abstract class LoginState {}

class LoggedIn extends LoginState {}

class LoggedOut extends LoginState {}

abstract class LoginEvent {}

class SignInPressed extends LoginEvent {}

class SignUpPressed extends LoginEvent {}

class MaybeLaterPressed extends LoginEvent {}

class WrongCredentials extends LoginEvent {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoggedOut()) {
    on<SignInPressed>((event, emit) {
      emit(LoggedIn());
    });
  }
}
