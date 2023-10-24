import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskman/models/task_model.dart';
import 'package:taskman/widgets/task_widget.dart';

import '../resources/colors_resources.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final df = DateFormat('dd-MM-yyyy');

  Future _settingModalBottomSheet(context) async {
    return await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return TaskWidget(task: widget.task);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: DateTime.now()
                          .difference(DateTime.fromMillisecondsSinceEpoch(
                              widget.task.date,
                              isUtc: true))
                          .inDays >
                      14 &&
                  widget.task.state == 'NOT_ASSIGNED'
              ? Colors.red[400]
              : const Color.fromARGB(255, 80, 80, 80),
          child: Column(children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.task.name.length > 18
                        ? '${widget.task.name.substring(0, 16)}...'
                        : widget.task.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.task.estimation,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(
                    df
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            widget.task.date,
                            isUtc: true))
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
                        fontSize: 12, color: ColorsResources().orangeMainColor),
                  )
                ],
              ),
            ),
          ]),
        ),
        onTap: () async {
          _settingModalBottomSheet(context).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
