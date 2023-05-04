import 'package:flutter/material.dart';

class MetaStyles {
  MetaStyles._();

  static InputDecoration customInputDecoration(
    BuildContext context, {
    String? labelText,
    Widget? label,
    String? hintText,
  }) =>
      InputDecoration(
        labelText: labelText,
        label: label,

        contentPadding: EdgeInsets.zero,
        isDense: true,
        //isCollapsed: true,
        hintText: hintText,
        focusColor: Color(0xFF00AEAD),
      );
}
