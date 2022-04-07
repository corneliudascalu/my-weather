import 'package:flutter/material.dart';
import 'package:weather/login/sign_in.dart';
import 'package:weather/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/splash": (context) => const SplashScreen(),
        "/sign-in": (context) => const SignInScreen(),
      },
      title: 'My Weather',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: const SplashScreen(),
    );
  }
}
