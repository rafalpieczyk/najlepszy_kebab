import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCreatingAccount == true ? 'Zarejestruj się' : 'Zaloguj się',
                style: const TextStyle(fontSize: 22),
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
              Text(errorMessage),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  if (isCreatingAccount == true) {
                    // rejestracja
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: widget.emailController.text,
                              password: widget.passwordController.text);
                    } catch (error) {
                      setState(() {
                        errorMessage = 'E-mail lub hasło nieprawidłowe';
                      });
                    }
                  } else {
                    // logowanie
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: widget.emailController.text,
                          password: widget.passwordController.text);
                    } catch (error) {
                      setState(() {
                        errorMessage = 'E-mail lub hasło nieprawidłowe';
                      });
                    }
                  }
                },
                child:
                    Text(isCreatingAccount == true ? 'Zarejestruj' : 'Zaloguj'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
