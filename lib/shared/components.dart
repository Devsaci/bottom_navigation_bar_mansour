
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart' show BorderRadius, FormFieldValidator, GestureTapCallback, Icon, IconButton, IconData, InputDecoration, OutlineInputBorder, Radius, TextEditingController, TextFormField, TextInputType, ValueChanged, VoidCallback, Widget;

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
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
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
