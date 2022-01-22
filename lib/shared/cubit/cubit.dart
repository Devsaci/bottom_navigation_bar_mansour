import 'package:bloc/bloc.dart';
import 'package:bottom_navigation_bar_mansour/models/archived_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/done_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/new_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void changeIndex(int index){

  }




}
