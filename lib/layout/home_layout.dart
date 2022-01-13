// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors
import 'package:bottom_navigation_bar_mansour/models/archived_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/done_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/new_tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  Database database;

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
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
        centerTitle: true,
      ),
      body: screens[currentIndex],
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
            Navigator.pop(context);
            isBottomSheetShown = false;
            setState(() {
              fabIcon = Icons.edit;
            });
          } else {
            scaffoldKey.currentState.showBottomSheet(
              (context) => Container(
                width: double.infinity,
                height: 120.0,
                color: Colors.redAccent,
              ),
            );
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.edit;
            });
          }
        },
        child: Icon(Icons.add_a_photo),
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
                'CREATE TABLE tasks ( title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print("table created");
        }).catchError((error) {
          print("Error when Creating Table");
        });
      },
      onOpen: (database) {
        print("database opened ");
      },
    );
  }

  void insertToDatabase() {
    database.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO tasks( title, date, time, status) VALUES( "title", "date", "time", "new")',
      )
          .then((value) {
        print('$value Inserted Successfully');
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
      return null;
    });
  }
}
