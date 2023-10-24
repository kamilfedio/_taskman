// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:taskman/pages/home_page.dart';
import 'package:taskman/resources/colors_resources.dart';
import 'package:taskman/services/task_api.dart';

import '../resources/input_decorator_resources.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key});

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> estimationList = [
    'ONE',
    'TWO',
    'THREE',
    'FIVE',
    'EIGHT',
    'THIRTEEN',
    'TWENTY_ONE'
  ];

  final List<String> specializationList = [
    'FRONTEND',
    'BACKEND',
    'DEVOPS',
    'UX/UI'
  ];

  Future<void> createTask() async {
    Map<String, String> body = {
      'name': _title.text,
      'estimation': dropDownEstimationValue,
      'specialization': dropDownSpecializationValue,
    };
    final res = await TaskService().createTask(body);
    if (res == 201) {
      showSnack('_task dodany');
    } else {
      showSnack('_błąd: $res');
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void showSnack(String code) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(code),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final TextEditingController _title = TextEditingController();
  String dropDownEstimationValue = 'ONE';
  String dropDownSpecializationValue = 'DEVOPS';

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stwórz',
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
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _title,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white54,
                        decoration: InputDecoration(
                          label: const Text(
                            'Tytuł',
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                          hintText: 'tytuł',
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
                            return 'Uzupełnij tytuł';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(20.0), // Border radius
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            label: const Text(
                              'Estymata',
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                            hintText: 'Estymata',
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton(
                              value: dropDownEstimationValue,
                              underline: Container(
                                height:
                                    0, // Set underline height to 0 to hide it
                              ),
                              dropdownColor:
                                  const Color.fromRGBO(34, 34, 34, 1),
                              style: const TextStyle(color: Colors.white),
                              items: estimationList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropDownEstimationValue = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(20.0), // Border radius
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            label: const Text(
                              'Specjalizacja',
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                            hintText: 'Specjalizacja',
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton(
                              value: dropDownSpecializationValue,
                              underline: Container(
                                height: 0,
                              ),
                              dropdownColor:
                                  ColorsResources().darkBackgroundColor,
                              style: const TextStyle(color: Colors.white),
                              items: specializationList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropDownSpecializationValue = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(
                                    color: Colors.white54,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Anuluj',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                createTask();
                              }
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
                            child: const Text('Dodaj'),
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
