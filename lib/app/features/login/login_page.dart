import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepszy_kebab/app/features/login/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..start(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFB6BEC9),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isCreatingAccount == true
                          ? 'Zarejestruj się'
                          : 'Zaloguj się',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: widget.emailController,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                    ),
                    TextField(
                      controller: widget.passwordController,
                      decoration: const InputDecoration(hintText: 'Hasło'),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(state.errorMessage),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF459D87),
                      ),
                      onPressed: () async {
                        if (isCreatingAccount == true) {
                          context.read<LoginCubit>().signIn(
                                email: widget.emailController.text,
                                password: widget.passwordController.text,
                              );
                        } else {
                          context.read<LoginCubit>().logIn(
                                email: widget.emailController.text,
                                password: widget.passwordController.text,
                              );
                        }
                      },
                      child: Text(
                        isCreatingAccount == true ? 'Zarejestruj' : 'Zaloguj',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF459D87)),
                      onPressed: (() {
                        if (isCreatingAccount == true) {
                          setState(() {
                            isCreatingAccount = false;
                          });
                        } else {
                          setState(() {
                            isCreatingAccount = true;
                          });
                        }
                      }),
                      child: Text(
                        isCreatingAccount == true
                            ? 'Zaloguj się na instniejące konto'
                            : 'Utwórz konto',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
