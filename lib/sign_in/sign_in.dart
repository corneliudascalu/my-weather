import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../style.dart';
import 'auth_bloc.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SignInForm(key: key);
  }
}

class _SignInForm extends StatefulWidget {
  const _SignInForm({Key? key}) : super(key: key);

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "test@email.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "Test123");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, SignInState>(
      listener: (context, state) {
        if (state is SignedIn) {
          Navigator.popUntil(context, ModalRoute.withName("/launcher"));
        } else if (state is FailedSignIn) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Sign in error: ${state.message}")));
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text("Sign In"),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                constraints: BoxConstraints.tight(const Size.fromWidth(500)),
                child: Column(
                  children: [
                    buildLabel("Email"),
                    TextFormField(
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: signInTextFieldDecoration(),
                      validator: (value) => value != null &&
                              value.isNotEmpty &&
                              value.contains("@")
                          ? null
                          : "Please input an email address",
                    ),
                    vertical16,
                    buildLabel("Password"),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: signInTextFieldDecoration(),
                      validator: (value) => value != null && value.length > 6
                          ? null
                          : "Please enter a longer password",
                    ),
                    vertical16,
                    OutlinedButton(
                        onPressed: () => {
                              if (_formKey.currentState?.validate() == true)
                                {
                                  context.read<AuthBloc>().add(SignInPressed(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                      ))
                                }
                            },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: signInButtonStyle(
                            backgroundColor: const Color(0xFF4cd964))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        TextButton(
                          onPressed: null,
                          child: Text("I do not have an account"),
                        ),
                        TextButton(
                          onPressed: null,
                          child: Text("I forgot password"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Align buildLabel(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
