import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/sign_in/auth_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _HomeScreen(key: key);
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, SignInState>(
      listener: (context, state) {
        // TODO
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignOutPressed());
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: const Center(
          child: Text(
            "Home sweet home",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
