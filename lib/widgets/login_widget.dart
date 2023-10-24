import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskman/pages/forget_password.dart';
import 'package:taskman/resources/colors_resources.dart';

import '../resources/input_decorator_resources.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isValidEmail(String text) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(text);
  }

  void singIn() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
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

          // haslo
          TextFormField(
            controller: _passwordController,
            style: const TextStyle(
              color: Colors.white,
            ),
            cursorColor: Colors.white54,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'password',
              hintStyle: const TextStyle(
                color: Colors.white54,
              ),
              enabledBorder: InputDecoratorResources().enabledBorderStyle,
              focusedBorder: InputDecoratorResources().focusedBorderStyle,
              errorBorder: InputDecoratorResources().errorBorderStyle,
              focusedErrorBorder: InputDecoratorResources().focusedBorderStyle,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Uzupełnij hasło';
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
                singIn();
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                ColorsResources().orangeMainColor,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            child: const Text('Zaloguj się'),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(
              'Nie pamiętam hasła',
              style: TextStyle(
                color: ColorsResources().orangeMainColor,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgetPasswoord(),
                  maintainState: false,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
