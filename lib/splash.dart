import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/login/login_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(), child: const SplashScreenWidget());
  }
}

class SplashScreenWidget extends StatelessWidget {
  final radius = 300.0;
  final circleColor = const Color(0x3595989a);

  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoggedOut) {
          return Stack(
            children: [
              buildCenterWidget(radius),
              buildSignInButtons(context),
            ],
          );
        } else {
          return buildCenterWidget(radius);
        }
      },
      listener: (context, state) {
        if (state is LoggedIn) {
          Navigator.pushNamed(context, "/sign-in");
        }
      },
    ));
  }

  Align buildSignInButtons(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
                onPressed: () => context.read<LoginBloc>().add(SignInPressed()),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
                style: signInButtonStyle(
                    backgroundColor: const Color(0xFF4cd964))),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => context.read<LoginBloc>().add(SignUpPressed()),
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
              style:
                  signInButtonStyle(backgroundColor: const Color(0xFF006FFF)),
            ),
            const TextButton(
              child: Text(
                "Maybe later",
                style: TextStyle(color: Color(0xFF2a2a2a)),
              ),
              onPressed: null,
            ),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }

  Center buildCenterWidget(double radius) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _circle(
              radius: radius,
              child: _circle(
                  radius: radius * 0.7, child: _circle(radius: radius * 0.4))),
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Transform.scale(
              child: Image.asset("assets/images/leaf-xxhdpi.png"),
              scale: 0.5,
            ),
          ),
          const Text(
            "My      Weather",
            style: TextStyle(fontSize: 35),
          ),
        ],
      ),
    );
  }

  ButtonStyle signInButtonStyle({Color backgroundColor = Colors.red}) {
    return OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(500, 56),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ));
  }

  Widget _circle({double radius = 300, Widget? child}) {
    return Center(
      child: Container(
          width: radius,
          height: radius,
          child: child,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: null,
              border: Border.all(
                  color: circleColor, style: BorderStyle.solid, width: 1))),
    );
  }
}
