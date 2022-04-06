import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final radius = 300.0;
  final circleColor = const Color(0x3595989a);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
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
