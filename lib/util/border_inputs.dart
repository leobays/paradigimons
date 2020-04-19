import 'package:flutter/material.dart';

class BorderInputs{
  borderStyle(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.black,
        width: 2
      ),
    );
  }
}