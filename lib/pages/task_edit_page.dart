// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:taskman/models/dev_model.dart';
import 'package:taskman/models/task_model.dart';
import 'package:taskman/resources/colors_resources.dart';
import 'package:taskman/services/firestore.dart';

import '../resources/input_decorator_resources.dart';
import '../services/task_api.dart';
import 'home_page.dart';

class TaskEditPage extends StatefulWidget {
  final TaskModel task;

  const TaskEditPage({super.key, required this.task});

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> status = [
    'NOT_ASSIGNED',
    'IN_PROGRESS',
    'CLOSED',
  ];

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
  Future<void> editTask() async {
    Map<String, dynamic> body = {
      'name': _title.text,
      'estimation': dropDownEstimationValue,
      'specialization': dropDownSpecializationValue,
    };
    if (dropDownDeveloperValue != '') {
      body['assignedTo'] = {
        "userId": dropDownDeveloperValue,
      };
    }
    final res = await TaskService().updateTask(body, widget.task.id);
    if (res == 200) {
      showSnack('_task zaktualizowany');
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

  Future<List<DevModel>> developers2 = FirestoreService().getDevsList();

  final TextEditingController _title = TextEditingController();
  String dropDownEstimationValue = 'ONE';
  String dropDownDeveloperValue = '';
  String dropDownSpecializationValue = 'DEVOPS';

  @override
  void initState() {
    _title.text = widget.task.name;
    dropDownDeveloperValue = widget.task.assignedTo ?? '';
    dropDownEstimationValue = widget.task.estimation;
    dropDownSpecializationValue = widget.task.specialization;
    super.initState();
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Edytuj',
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
                                  ColorsResources().darkBackgroundColor,
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
                      widget.task.state != 'NOT_ASSIGNED' &&
                              widget.task.state != 'CLOSED'
                          ? FutureBuilder<List<DevModel>>(
                              future: developers2,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text(
                                      "Wystąpił błąd: ${snapshot.error}");
                                } else if (snapshot.hasData) {
                                  List<DevModel>? devs = snapshot.data;

                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        label: const Text(
                                          'Przypisanie',
                                          style: TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ),
                                        hintText: 'Przypisanie',
                                        hintStyle: const TextStyle(
                                          color: Colors.white54,
                                        ),
                                        enabledBorder: InputDecoratorResources()
                                            .enabledBorderStyle,
                                        focusedBorder: InputDecoratorResources()
                                            .focusedBorderStyle,
                                        errorBorder: InputDecoratorResources()
                                            .errorBorderStyle,
                                        focusedErrorBorder:
                                            InputDecoratorResources()
                                                .focusedBorderStyle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: DropdownButton<String>(
                                          value: dropDownDeveloperValue,
                                          underline: Container(
                                            height: 0,
                                          ),
                                          dropdownColor: ColorsResources()
                                              .darkBackgroundColor,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          items: devs?.map((DevModel dev) {
                                            return DropdownMenuItem<String>(
                                              value: dev.id,
                                              child: Text(dev.name),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              dropDownDeveloperValue = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Text("Brak danych");
                                }
                              },
                            )
                          : Container(),
                      const SizedBox(
                        height: 30,
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
                                editTask();
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
                            child: const Text('Zapisz'),
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
