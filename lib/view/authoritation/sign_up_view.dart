import 'package:firebase_todo/bloc/AuthBloc/todo_bloc.dart';
import 'package:firebase_todo/bloc/AuthBloc/todo_event.dart';
import 'package:firebase_todo/bloc/AuthBloc/todo_state.dart';
import 'package:firebase_todo/components/const_colors.dart';
import 'package:firebase_todo/widget/app_button.dart';
import 'package:firebase_todo/widget/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _surnameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock,
                    size: 150,
                    color: AppColors.pink
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                      obscureText: false,
                      controller: _nameController,
                      hintText: "Name"),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextField(
                      obscureText: false,
                      controller: _surnameController,
                      hintText: "Surname"),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextField(
                      obscureText: false,
                      controller: _emailController,
                      hintText: "Email"),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextField(
                      obscureText: true,
                      controller: _passwordController,
                      hintText: "Password"),
                  const SizedBox(
                    height: 10,
                  ),
                  AppButton(
                    name: "Sign Up",
                    height: 55,
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(SignUpAuthEvent(
                          email: _emailController.text,
                          password: _passwordController.text,
                          surname: _surnameController.text,
                          name: _nameController.text));
                      context.goNamed('/MyApp');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed('/signIn');
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.pink,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
