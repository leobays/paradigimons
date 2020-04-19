import 'package:flutter/material.dart';

class ChangeFocusForm{
  changeFocus(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}