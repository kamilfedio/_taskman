// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskman/pages/auth_page.dart';
import 'package:taskman/resources/colors_resources.dart';

import '../resources/input_decorator_resources.dart';

class ForgetPasswoord extends StatefulWidget {
  const ForgetPasswoord({super.key});

  @override
  State<ForgetPasswoord> createState() => _ForgetPasswoordState();
}

class _ForgetPasswoordState extends State<ForgetPasswoord> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  bool isValidEmail(String text) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(text);
  }

  void recoverPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
          maintainState: false,
        ),
      );
    } on FirebaseAuthException catch (e) {
      loginError(e.code);
    }
  }

  void loginError(String e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(e),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsResources().darkBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Wyślij email z przypomnieniem hasła',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //email
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white54,
                        decoration: InputDecoration(
                          hintText: 'email',
                          hintStyle: const TextStyle(
                            color: Colors.white54,
                          ),
                          enabledBorder:
                              InputDecoratorResources().enabledBorderStyle,
                          focusedBorder:
                              InputDecoratorResources().focusedBorderStyle,
                          errorBorder:
                              InputDecoratorResources().errorBorderStyle,
                          focusedErrorBorder:
                              InputDecoratorResources().focusedBorderStyle,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Uzupełnij email';
                          } else if (!isValidEmail(value)) {
                            return 'Błędny email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // wróc
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AuthPage(),
                                  maintainState: false,
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                ColorsResources().orangeMainColor,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            child: const Text('Wróć'),
                          ),
                          //wyślij email
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                recoverPassword();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                ColorsResources().orangeMainColor,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), 
                                ),
                              ),
                            ),
                            child: const Text('Wyślij email'),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
