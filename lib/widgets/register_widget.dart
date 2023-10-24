// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskman/resources/colors_resources.dart';
import 'package:taskman/services/firestore.dart';

import '../resources/input_decorator_resources.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isValidEmail(String text) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(text);
  }

  void signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsResources().orangeLightColor,
            ),
          );
        });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      FirestoreService fireService = FirestoreService();
      fireService.addDev(
          user!.uid, _nameController.text, _emailController.text);
    } on FirebaseAuthException catch (e) {
      loginError(e.code);
    }
    Navigator.pop(context);
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
    return Form(
      key: _formKey,
      child: Column(children: [
        //imie i nazwisko
        TextFormField(
          controller: _nameController,
          style: const TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white54,
          decoration: InputDecoration(
            hintText: 'Podaj login',
            hintStyle: const TextStyle(
              color: Colors.white54,
            ),
            enabledBorder: InputDecoratorResources().enabledBorderStyle,
            focusedBorder: InputDecoratorResources().focusedBorderStyle,
            errorBorder: InputDecoratorResources().errorBorderStyle,
            focusedErrorBorder: InputDecoratorResources().focusedBorderStyle,
          ),
          validator: (value) {
            if ((value == null || value.isEmpty)) {
              return 'Podaj imię i nazwisko';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        // email
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
            enabledBorder: InputDecoratorResources().enabledBorderStyle,
            focusedBorder: InputDecoratorResources().focusedBorderStyle,
            errorBorder: InputDecoratorResources().errorBorderStyle,
            focusedErrorBorder: InputDecoratorResources().focusedBorderStyle,
          ),
          validator: (value) {
            if ((value == null || value.isEmpty)) {
              return 'Podaj email';
            } else if (!isValidEmail(value)) {
              return 'Błędny email';
            }
            return null;
          },
        ),
        // hasło
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: _passwordController,
          style: const TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white54,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'hasło',
            hintStyle: const TextStyle(
              color: Colors.white54,
            ),
            enabledBorder: InputDecoratorResources().enabledBorderStyle,
            focusedBorder: InputDecoratorResources().focusedBorderStyle,
            errorBorder: InputDecoratorResources().errorBorderStyle,
            focusedErrorBorder: InputDecoratorResources().focusedBorderStyle,
          ),
          validator: (value) {
            if ((value == null || value.isEmpty)) {
              return 'Podaj hasło';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        //powtórz hasło
        TextFormField(
          style: const TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white54,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'powtórz hasło',
            hintStyle: const TextStyle(
              color: Colors.white54,
            ),
            enabledBorder: InputDecoratorResources().enabledBorderStyle,
            focusedBorder: InputDecoratorResources().focusedBorderStyle,
            errorBorder: InputDecoratorResources().errorBorderStyle,
            focusedErrorBorder: InputDecoratorResources().focusedBorderStyle,
          ),
          validator: (value) {
            if ((value == null || value.isEmpty)) {
              return 'Powtórz hasło';
            } else if (value != _passwordController.text) {
              return 'Hasła są różne';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              signUp();
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                ColorsResources().orangeMainColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Tutaj ustaw promień
              ),
            ),
          ),
          child: const Text('Zarejestruj się'),
        )
      ]),
    );
  }
}
