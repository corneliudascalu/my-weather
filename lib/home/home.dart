import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/login/login_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return LoginBloc();
      },
      child: HomeScreen(key: key),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoggedOut) {
          Navigator.popUntil(context, ModalRoute.withName("/sign-in"));
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<LoginBloc>().add(SignOutPressed());
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
