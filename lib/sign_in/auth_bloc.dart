import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SignInState {}

class NavigateToSignIn extends SignInState {}

class NavigateToSignUp extends SignInState {}

class SignedIn extends SignInState {
  final String? email;

  SignedIn(this.email);
}

class FailedSignIn extends SignInState {
  final String message;

  FailedSignIn(this.message);
}

class SignedOut extends SignInState {}

abstract class SignInEvent {}

class GoToSignInPressed extends SignInEvent {}

class GoToSignUpPressed extends SignInEvent {}

class SignUpPressed extends SignInEvent {}

class SignInPressed extends SignInEvent {
  final String email;
  final String password;

  SignInPressed(this.email, this.password);
}

class MaybeLaterPressed extends SignInEvent {}

class WrongCredentials extends SignInEvent {}

class SignOutPressed extends SignInEvent {}

class AuthBloc extends Bloc<SignInEvent, SignInState> {
  AuthBloc() : super(SignedOut()) {
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
        emit(SignedOut());
      },
    );
    on<GoToSignUpPressed>((event, emit) => emit(NavigateToSignUp()));
  }
}
