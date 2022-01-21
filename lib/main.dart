// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:bottom_navigation_bar_mansour/shared/cubit/bloc_observer.dart';
import 'package:flutter/material.dart';

import 'layout/home_layout.dart';

void main() {
  BlocOverrides.runZoned(
        () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );

  runApp(MyApp());
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
