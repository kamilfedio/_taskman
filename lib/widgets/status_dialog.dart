// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:taskman/resources/colors_resources.dart';

import '../models/task_model.dart';
import '../pages/home_page.dart';
import '../services/task_api.dart';

class StatusDialog extends StatefulWidget {
  final TaskModel task;
  const StatusDialog({super.key, required this.task});

  @override
  State<StatusDialog> createState() => _StatusDialogState();
}

class _StatusDialogState extends State<StatusDialog> {
  int selectedOption = 1;

  final Map<int, String> status = {
    1: 'NOT_ASSIGNED',
    2: 'IN_PROGRESS',
    3: 'CLOSED',
  };
  Future<void> editTaskState() async {
    await TaskService().updateStateTask(
      widget.task.id,
      {
        'state': status[selectedOption],
      },
    );
    const snackBar = SnackBar(
      content: Text('_task zmienił status'),
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
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 80, 80, 80),
      title: const Text(
        'Zmień status',
        style: TextStyle(color: Colors.white),
      ),
      content: widget.task.state == 'NOT_ASSIGNED'
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text(
                    'NOT_ASSIGNED',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Radio(
                    value: 1,
                    fillColor: MaterialStateProperty.all<Color>(
                      ColorsResources().orangeMainColor,
                    ),
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text(
                    'IN_PROGRESS',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Radio(
                    fillColor: MaterialStateProperty.all<Color>(
                      ColorsResources().orangeMainColor,
                    ),
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    editTaskState();
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.transparent,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    'Zmień status',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text(
                    'NOT_ASSIGNED',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Radio(
                    value: 1,
                    fillColor: MaterialStateProperty.all<Color>(
                      ColorsResources().orangeMainColor,
                    ),
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text(
                    'IN_PROGRESS',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Radio(
                    fillColor: MaterialStateProperty.all<Color>(
                      ColorsResources().orangeMainColor,
                    ),
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text(
                    'CLOSED',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Radio(
                    fillColor: MaterialStateProperty.all<Color>(
                      ColorsResources().orangeMainColor,
                    ),
                    value: 3,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    editTaskState();
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.transparent,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    'Zmień status',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
