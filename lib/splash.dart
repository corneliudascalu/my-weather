import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/sign_in/auth_bloc.dart';
import 'package:weather/style.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _SplashScreenWidget();
  }
}

class _SplashScreenWidget extends StatelessWidget {
  final radius = 300.0;
  final circleColor = const Color(0x3595989a);

  const _SplashScreenWidget({Key? key}) : super(key: key);

  Future<bool> _delay() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, SignInState>(
      builder: (context, state) {
        if (state is SignedOut) {
          return FutureBuilder<bool>(
              future: _delay(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return _buildCenterWidget(radius);
                } else {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: _buildCenterWidget(radius),
                      ),
                      _buildSignInButtons(context),
                    ],
                  );
                }
              });
        } else {
          return _buildCenterWidget(radius);
        }
      },
      listener: (context, state) {
        if (state is NavigateToSignIn) {
          Navigator.pushNamed(context, "/sign-in");
        } else if (state is NavigateToSignUp) {
          Navigator.pushNamed(context, "/sign-up");
        }
      },
      buildWhen: (previous, current) {
        return (current is SignedOut);
      },
    ));
  }

  Align _buildSignInButtons(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
                onPressed: () =>
                    context.read<AuthBloc>().add(GoToSignInPressed()),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
                style: signInButtonStyle(
                    backgroundColor: const Color(0xFF4cd964))),
            vertical16,
            OutlinedButton(
              onPressed: () => context.read<AuthBloc>().add(GoToSignUpPressed()),
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

  Center _buildCenterWidget(double radius) {
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
