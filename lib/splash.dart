import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/login/login_bloc.dart';
import 'package:weather/style.dart';

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
        if (state is NavigateToSignIn) {
          Navigator.pushNamed(context, "/sign-in");
        }
      },
      buildWhen: (previous, current) {
        return (current is LoggedOut);
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
                onPressed: () =>
                    context.read<LoginBloc>().add(GoToSignInPressed()),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
                style: signInButtonStyle(
                    backgroundColor: const Color(0xFF4cd964))),
            vertical16,
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
            vertical8
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
