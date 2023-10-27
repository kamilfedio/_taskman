// ignore_for_file: empty_catches

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/task_model.dart';

class TaskService {
  // ignore: constant_identifier_names
  static const BASE_URL =
      "https://task-manager-api-401408.lm.r.appspot.com/project/";
  final String projectId = dotenv.env['PROJECT_ID']!;
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'user-id': dotenv.env['USER_ID']!,
    'secret-key': dotenv.env['SECRET_KEY']!,
  };

  Future<int> createTask(Map<String, String> body) async {
    try {
      final res = await http.post(
        Uri.parse(
          '$BASE_URL$projectId/task/',
        ),
        headers: headers,
        body: jsonEncode(body),
      );
      return res.statusCode;
    } catch (e) {
      return 400;
    }
  }

  Future<int> updateTask(Map<String, dynamic> body, String id) async {
    try {
      final res = await http.put(
        Uri.parse('$BASE_URL$projectId/task/$id'),
        headers: headers,
        body: jsonEncode(body),
      );
      return res.statusCode;
    } catch (e) {
      return 400;
    }
  }

  Future<int> updateStateTask(String id, Map body) async {
    try {
      final res = await http.put(
        Uri.parse(
          '$BASE_URL$projectId/task/$id/state/',
        ),
        headers: headers,
        body: jsonEncode(
          body,
        ),
      );
      return res.statusCode;
    } catch (e) {
      return 400;
    }
  }

  Future<List<TaskModel>> getTasks(String filter) async {
    List<TaskModel> tasks = [];
    final response = await http.get(
      Uri.parse('$BASE_URL$projectId/task/'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final user = FirebaseAuth.instance.currentUser!;
      final Map<String, String> filters = {
        'Nie przypisane': 'NOT_ASSIGNED',
        'Trwające': 'IN_PROGRESS',
        'Zamknięte': 'CLOSED',
      };

      List taskBody = jsonDecode(response.body);

      for (Map<String, dynamic> task in taskBody) {
        if (task['state'] != 'DELETED') {
          TaskModel singleTask = TaskModel(
            id: task['_id'] ?? '',
            assignedTo: '',
            name: task['credentials']['name'] ?? '',
            estimation: task['credentials']['estimation'] ?? '',
            specialization: task['credentials']['specialization'] ?? '',
            date: task['createdAt'] ?? 0,
            state: task['state'] ?? '',
          );
          try {
            singleTask.assignedTo = task['credentials']['assignedTo']['userId'];
          } catch (e) {}
          if (filter == 'Dla mnie' && singleTask.assignedTo == user.uid) {
            tasks.add(singleTask);
          } else if (filter == '') {
            tasks.add(singleTask);
          } else if (task['state'] == filters[filter]) {
            tasks.add(singleTask);
          }
        }
      }

      return tasks.reversed.toList();
    } else {
      return tasks;
    }
  }
}
