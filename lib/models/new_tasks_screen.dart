// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bottom_navigation_bar_mansour/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTasksScreen extends StatelessWidget {

  late final  List<Map> tasks;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20.0
        ),
        child: Container(
          width: double.infinity,
          height: 1,
          color: Colors.indigo,
        ),
      ),
      itemCount: 10,
    );
  }
}
