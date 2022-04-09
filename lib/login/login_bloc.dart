import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoginState {}

class CheckingSession extends LoginState {}

class LoggedOut extends LoginState {}

abstract class LoginEvent {}

class SignInPressed extends LoginEvent {
  final String email;
  final String password;

  SignInPressed.empty()
      : email = "",
        password = "";

  SignInPressed(this.email, this.password);
}

class SignUpPressed extends LoginEvent {}

class MaybeLaterPressed extends LoginEvent {}

class WrongCredentials extends LoginEvent {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoggedOut()) {
    on<SignInPressed>((event, emit) {
      emit(CheckingSession());
    });
  }
}
