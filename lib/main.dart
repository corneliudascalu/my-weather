import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/firebase_options.dart';
import 'package:weather/home/home.dart';
import 'package:weather/sign_in/auth_bloc.dart';
import 'package:weather/sign_in/sign_in.dart';
import 'package:weather/sign_in/sign_up.dart';
import 'package:weather/sign_in/user_repository.dart';
import 'package:weather/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          initialData: null,
          create: (context) =>
              UserRepository(FirebaseAuth.instance).authStateChanges,
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        )
      ],
      child: MaterialApp(
        routes: {
          "/launcher": (context) => const Launcher(),
          "/sign-in": (context) => const SignIn(),
          "/sign-up": (context) => const SignUp(),
        },
        title: 'My Weather',
        theme: ThemeData(primarySwatch: Colors.lightBlue),
        initialRoute: "/launcher",
      ),
    );
  }
}

class Launcher extends StatelessWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User?>();

    if (user != null) {
      return const Home();
    } else {
      return const Splash();
    }
  }
}
