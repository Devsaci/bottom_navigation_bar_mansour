// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:bottom_navigation_bar_mansour/shared/bloc_observer.dart';
import 'package:flutter/material.dart';

import 'layout/home_layout.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
