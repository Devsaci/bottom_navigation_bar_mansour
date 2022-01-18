// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:bottom_navigation_bar_mansour/models/archived_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/done_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/new_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/shared/components.dart';
import 'package:bottom_navigation_bar_mansour/shared/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late Database database;

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  List<String> titles = [
    " New Tasks",
    " Done Tasks",
    " Archive Tasks",
  ];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  late var dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
        centerTitle: true,
      ),
      body: ConditionalBuilder(
        condition: tasks.isNotEmpty,
        builder: (BuildContext context) => screens[currentIndex],
        fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // try {
          //   var name = await getName();
          //   // print(name);
          //   throw('debug !!! ${name.toString()}');
          // } catch (error) {
          //   print("error ${error.toString()}");
          // }
          ///////////////////////////////
          // getName().then((value) {
          //   print(value);
          //   print("Operation");
          //   // throw('debug !!! ');
          // }).catchError((error) {
          //   print("error ${error.toString()}");
          // });
          ////////////////////////////////

          // insertToDatabase();
          ////////////////////////////////

          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              insertToDatabase(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text,
              ).then((value) {
                Navigator.pop(context!);
                isBottomSheetShown = false;
                setState(() {
                  fabIcon = Icons.edit;
                });
              });
            }
          } else {
            scaffoldKey.currentState
                ?.showBottomSheet(
                  (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      color: Colors.grey[200],
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                              controller: titleController,
                              type: TextInputType.text,
                              onTape: () {
                                print('email Taped');
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'email must not be empty';
                                }
                                return null;
                              },
                              label: 'Task Title',
                              prefix: Icons.title,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              controller: timeController,
                              type: TextInputType.datetime,
                              // isClickable: false,
                              onTape: () {
                                print('Timing Taped');
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  timeController.text =
                                      (value?.format(context)).toString();
                                  print(value?.format(context));
                                });
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Timing must not be empty';
                                }
                                return null;
                              },
                              label: 'Task Time',
                              prefix: Icons.watch_later_outlined,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              controller: dateController,
                              type: TextInputType.datetime,
                              // isClickable: false,
                              onTape: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2022-02-01'))
                                    .then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                  print(DateFormat.yMMMd().format(value));
                                });
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Date must not be empty';
                                }
                                return null;
                              },
                              label: 'Task Date',
                              prefix: Icons.calendar_today,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  elevation: 30,
                )
                .closed
                .then((value) {
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          print(index);
        },
        currentIndex: currentIndex,
        backgroundColor: Colors.amber,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        selectedFontSize: 25,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
            ),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archived',
          ),
        ],
      ),
    );
  }

  Future<String> getName() async {
    return "Saci Zakaria";
  }

  void createDatabase() async {
    database = await openDatabase(
      "todo.db",
      version: 1,
      // id integer
      // title String
      // date String
      // time String
      // status String
      onCreate: (database, version) {
        print("database created ");
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print("table created");
        }).catchError((error) {
          print("Error when Creating Table");
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          setState(() {
            tasks = value; tasks = value;
          });
          //
          print(tasks[
              0]); //{id: 1, title: go to swiming, date: Jan 18, 2022, time: 10:19, status: new}
          print(tasks[
              1]); //{id: 2, title: go to market, date: Jan 19, 2022, time: 11:20, status: new}
        });
        print("database opened ");
      },
    );
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks( title, date, time, status) VALUES( "$title", "$date", "$time", "new")',
      )
          .then((value) {
        print('$value Inserted Successfully');
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
