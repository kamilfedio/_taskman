// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskman/models/task_model.dart';
import 'package:taskman/pages/home_page.dart';
import 'package:taskman/pages/task_edit_page.dart';
import 'package:taskman/resources/colors_resources.dart';
import 'package:taskman/services/task_api.dart';
import 'package:taskman/widgets/status_dialog.dart';

import '../models/dev_model.dart';
import '../services/firestore.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  final df = DateFormat('dd-MM-yyyy');

  Future<void> _deleteTask() async {
    await TaskService().updateStateTask(widget.task.id, {'state': 'DELETED'});
    const snackBar = SnackBar(
      content: Text('_task usunięty'),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsResources().darkBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.task.name,
              style: TextStyle(
                color: ColorsResources().orangeMainColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(
                  df
                      .format(
                        DateTime.fromMillisecondsSinceEpoch(
                          widget.task.date,
                          isUtc: true,
                        ),
                      )
                      .toString(),
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.task.state,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorsResources().orangeWithOpacity,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  'Specjalizacja: ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
                Text(
                  widget.task.specialization,
                  style: TextStyle(
                    color: ColorsResources().orangeWithOpacity,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  'Wykonawca: ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
                FutureBuilder<List<DevModel>>(
                  future: FirestoreService()
                      .getDevsList(), // Pobierz listę DevModel za pomocą funkcji
                  builder: (context, snapshot) {
                    Map<String, String> idToNameMap = {}; // Tworzymy mapę tutaj

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // W trakcie pobierania danych
                    } else if (snapshot.hasError) {
                      return Text(
                        'Wystąpił błąd: ${snapshot.error}',
                        style: TextStyle(
                          color: ColorsResources().orangeWithOpacity,
                          fontSize: 14,
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text(
                        'Brak dostępnych danych.',
                        style: TextStyle(
                          color: ColorsResources().orangeWithOpacity,
                          fontSize: 14,
                        ),
                      );
                    } else {
                      // Dane zostały pobrane poprawnie
                      List<DevModel>? devsList = snapshot.data;

                      // Tworzymy mapę idToNameMap na podstawie devsList
                      for (DevModel dev in devsList!) {
                        idToNameMap[dev.id] = dev.name;
                      }

                      return Text(
                        idToNameMap[widget.task.assignedTo] ?? 'Błąd',
                        style: TextStyle(
                          color: ColorsResources().orangeWithOpacity,
                          fontSize: 14,
                        ),
                      );
                    }
                  },
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            widget.task.state != 'CLOSED'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _deleteTask();
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          'Usuń',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatusDialog(
                                  task: widget.task,
                                );
                              });
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                color: ColorsResources().orangeMainColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TaskEditPage(task: widget.task),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            ColorsResources().orangeMainColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: const Text('Edytuj'),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
