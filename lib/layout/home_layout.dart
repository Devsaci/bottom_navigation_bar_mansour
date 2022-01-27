// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:bottom_navigation_bar_mansour/models/archived_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/done_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/models/new_tasks_screen.dart';
import 'package:bottom_navigation_bar_mansour/shared/components/components.dart';
import 'package:bottom_navigation_bar_mansour/shared/components/constants.dart';
import 'package:bottom_navigation_bar_mansour/shared/cubit/cubit.dart';
import 'package:bottom_navigation_bar_mansour/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  late var dateController = TextEditingController();

  @override
  Widget build(BuildContext? context) {
    return BlocProvider(
      //onChange => AppCubit, Change { currentState: Instance of 'AppInitialState', nextState: Instance of 'AppCreateDatabaseState' }
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);

            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(cubit.titles[cubit.currentIndex]),
                centerTitle: true,
              ),
              body: ConditionalBuilder(
                condition: true,
                builder: (BuildContext context) =>
                    cubit.screens[cubit.currentIndex],
                fallback: (BuildContext context) =>
                    Center(child: CircularProgressIndicator()),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // cubit.insertToDatabase(
                  //   title: titleController.text,
                  //   time: timeController.text,
                  //   date: dateController.text,
                  // );
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

                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                      );
                      // insertToDatabase(
                      //   title: titleController.text,
                      //   date: dateController.text,
                      //   time: timeController.text,
                      // ).then((value) {
                      //   getDataFromDatabase(database).then((value) {
                      //     Navigator.pop(context);
                      //     // setState(() {
                      //     //   isBottomSheetShown = false;
                      //     //   fabIcon = Icons.edit;
                      //     //   tasks = value;
                      //     //   if (kDebugMode) {
                      //     //     print(tasks[0]);
                      //     //     print(tasks[1]);
                      //     //     print(tasks[2]);
                      //     //     print(tasks[3]);
                      //     //     print(tasks[4]);
                      //     //   }
                      //     // },);
                      //   });
                      // });
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
                                              (value?.format(context))
                                                  .toString();
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
                                                lastDate: DateTime.parse(
                                                    '2022-02-01'))
                                            .then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                          print(
                                              DateFormat.yMMMd().format(value));
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
                      cubit.changeBottomSheetState(
                        isShow: false,
                        icon: Icons.edit,
                      );
                    });
                    cubit.changeBottomSheetState(
                      isShow: true,
                      icon: Icons.add,
                    );
                  }
                },
                child: Icon(cubit.fabIcon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeIndex(index);
                  // setState(() {
                  //   currentIndex = index;
                  // });
                  print(index);
                },
                currentIndex: AppCubit.get(context).currentIndex,
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
          }),
    );
  }

// Future<String> getName() async {
//   return "Saci Zakaria";
// }

}
