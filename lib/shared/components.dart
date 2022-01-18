
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show BorderRadius, Column, EdgeInsets, FontWeight, FormFieldValidator, GestureTapCallback, Icon, IconData, MainAxisSize, Padding, Radius, Row, SizedBox, Text, TextEditingController, TextInputType, TextStyle, ValueChanged, VoidCallback, Widget;

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTape,
  // bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      // enabled: isClickable,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null ? IconButton(
          onPressed: suffixPressed,
          icon :Icon(suffix),
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTape,
    );

Widget buildTaskItem(Map model) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text('${ model['time']}'),
      ),
      SizedBox(
        width: 20.0,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${ model['title']}',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            '${ model['date']}',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    ],
  ),
);
