import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoginState {}

class NavigateToSignIn extends LoginState {}

class SignedIn extends LoginState {
  final String? email;

  SignedIn(this.email);
}

class FailedSignIn extends LoginState {
  final String message;

  FailedSignIn(this.message);
}

class LoggedOut extends LoginState {}

abstract class LoginEvent {}

class GoToSignInPressed extends LoginEvent {}

class SignUpPressed extends LoginEvent {}

class SignInPressed extends LoginEvent {
  final String email;
  final String password;

  SignInPressed(this.email, this.password);
}

class MaybeLaterPressed extends LoginEvent {}

class WrongCredentials extends LoginEvent {}

class SignOutPressed extends LoginEvent {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoggedOut()) {
    on<GoToSignInPressed>((event, emit) => emit(NavigateToSignIn()));
    on<SignInPressed>((event, emit) async {
      try {
        var userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email, password: event.password);
        var userEmail = userCredential.user?.email;
        emit(SignedIn(userEmail));
      } on FirebaseAuthException catch (e) {
        emit(FailedSignIn(e.message ?? "Unknown error"));
      }
    });
    on<SignOutPressed>(
      (event, emit) async {
        await FirebaseAuth.instance.signOut();
        emit(LoggedOut());
      },
    );
  }
}
