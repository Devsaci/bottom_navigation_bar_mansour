// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:html';

import 'package:bottom_navigation_bar_mansour/shared/components/components.dart';
import 'package:bottom_navigation_bar_mansour/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Stopped NewTasksScreen"),
    );
    // return ListView.separated(
    //   itemBuilder: (context, index) => buildTaskItem(tasks[index]),
    //   separatorBuilder: (context, index) => Padding(
    //     padding: const EdgeInsetsDirectional.only(
    //       start: 20.0
    //     ),
    //     child: Container(
    //       width: double.infinity,
    //       height: 1,
    //       color: Colors.indigo,
    //     ),
    //   ),
    //   itemCount: tasks.length,
    // );
  }
}
