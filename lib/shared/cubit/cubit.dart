import 'package:bloc/bloc.dart';
import 'package:bottom_navigation_bar_mansour/models/archived_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/done_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/new_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/shared/components/constants.dart';
import 'package:bottom_navigation_bar_mansour/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
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

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }


  late Database database;
  void createDatabase(){
   openDatabase(
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
          // setState(() {
          //   tasks = value;
          //   tasks = value;
          // });
          //
          print(tasks[
              0]); //{id: 1, title: go to swiming, date: Jan 18, 2022, time: 10:19, status: new}
          print(tasks[
              1]); //{id: 2, title: go to market, date: Jan 19, 2022, time: 11:20, status: new}
        });
        print("database opened ");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
   });
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
