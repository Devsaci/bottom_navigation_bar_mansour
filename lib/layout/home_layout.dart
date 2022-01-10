// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("79. Bottom Navigation Bar"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_a_photo),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {

          });
          currentIndex = index;
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
