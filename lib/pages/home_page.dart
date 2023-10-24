// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskman/pages/auth_page.dart';
import 'package:taskman/pages/task_create_page.dart';
import 'package:taskman/resources/colors_resources.dart';
import 'package:taskman/services/task_api.dart';

import '../widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final List<String> _filters = [
    'Dla mnie',
    'Nie przypisane',
    'Trwające',
    'Zamknięte',
  ];
  String currentlyActive = '';

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const AuthPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsResources().darkBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskCreatePage(),
            ),
          );
        },
        backgroundColor: ColorsResources().orangeMainColor,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Twoje',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        GestureDetector(
                          child: const Icon(
                            Icons.logout_outlined,
                            color: Colors.white70,
                          ),
                          onTap: () {
                            signOut();
                          },
                        )
                      ],
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
                          'taski',
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                          children: _filters.map(
                        (filter) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (currentlyActive == filter) {
                                    currentlyActive = '';
                                  } else {
                                    currentlyActive = filter;
                                  }
                                });
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  currentlyActive == filter
                                      ? ColorsResources().orangeMainColor
                                      : Colors.transparent,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(
                                      color: currentlyActive == filter
                                          ? Colors.transparent
                                          : Colors.white54,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              child: Text(
                                filter,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: currentlyActive == filter
                                      ? Colors.white
                                      : Colors.white70,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList()),
                    ],
                  ),
                ),
                FutureBuilder<List>(
                  future: TaskService().getTasks(currentlyActive),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                        'Błąd pobierania danych',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      List? allTasks = snapshot.data;
                      if (allTasks!.isNotEmpty) {
                        return Column(
                          children: allTasks.map((taskData) {
                            return TaskCard(
                              task: taskData,
                            );
                          }).toList(),
                        );
                      } else {
                        return const Text(
                          'Brak danych',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
                    } else {
                      return const Text(
                        'Brak danych',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
