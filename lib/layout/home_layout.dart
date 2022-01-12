// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bottom_navigation_bar_mansour/models/archived_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/done_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/new_tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}
// late Database database;
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

  @override
  void initState() {
    creatDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          getName().then((value) {
            print(value);
            print("Operation");
            // throw('debug !!! ');
          }).catchError((error) {
            print("error ${error.toString()}");
          });
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
}

// Instance of 'Future<String>'
Future<String> getName() async {
  return "Saci Zakaria";
}

Future<void> creatDatabase() async {
  var database = await openDatabase(
    "todo.db",
    version: 1,
    onCreate: (Database database, int version) {
      print("database created ");
      database
          .execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)")
          .then((value) => print("table created"))
          .catchError(
            (error) => print("Error when Creating Table"),
          );
    },
    onOpen: (Database database) {
      print("database opened ");
    },
  );
}

void insertToDatabase(){
 var database;
  database.transaction((txn){
    txn.rawInsert("sql").then((value){}).cat;
  });
}
