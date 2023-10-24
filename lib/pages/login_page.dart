import 'package:flutter/material.dart';
import 'package:taskman/resources/colors_resources.dart';
import 'package:taskman/widgets/login_widget.dart';
import 'package:taskman/widgets/register_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color activeColor = Colors.white;
  Color inactiveColor = Colors.white54;

  bool loginPageBool = true;
  bool registerPageBool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsResources().darkBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                // logo
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Witaj w',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '_',
                          style: TextStyle(
                            color: ColorsResources().orangeMainColor,
                            fontSize: 38,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'task',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Man',
                          style: TextStyle(
                            color: ColorsResources().orangeMainColor,
                            fontSize: 38,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Logowanie',
                                  style: TextStyle(
                                    color: loginPageBool
                                        ? activeColor
                                        : inactiveColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                loginPageBool
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          '.',
                                          style: TextStyle(
                                            fontSize: 36,
                                            color: ColorsResources()
                                                .orangeMainColor,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            )),
                        onTap: () {
                          setState(() {
                            loginPageBool = true;
                            registerPageBool = false;
                          });
                        }),
                    const Text(
                      '|',
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              'Rejestracja',
                              style: TextStyle(
                                color: registerPageBool
                                    ? activeColor
                                    : inactiveColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            registerPageBool
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '.',
                                      style: TextStyle(
                                        fontSize: 36,
                                        color:
                                            ColorsResources().orangeMainColor,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          loginPageBool = false;
                          registerPageBool = true;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                loginPageBool ? const LoginWidget() : const RegisterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
