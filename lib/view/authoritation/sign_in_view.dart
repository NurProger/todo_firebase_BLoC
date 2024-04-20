import 'package:firebase_todo/bloc/AuthBloc/todo_bloc.dart';
import 'package:firebase_todo/bloc/AuthBloc/todo_event.dart';
import 'package:firebase_todo/bloc/AuthBloc/todo_state.dart';
import 'package:firebase_todo/components/const_colors.dart';
import 'package:firebase_todo/widget/app_button.dart';
import 'package:firebase_todo/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (BuildContext context, state) =>
      MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock,
                    size: 150,
                    color: AppColors.pink,
                  ),
                  const SizedBox(
                    height: 20,
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
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context).add(SignInAuthEvent(
                            email: _emailController.text,
                            password: _passwordController.text));
                        context.goNamed("/MyApp");
                      },
                      name: "Sign In",
                      height: 55),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do not have an account?",
                        style: TextStyle(fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed('/signUp');
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 15,
                            color:AppColors.pink,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
