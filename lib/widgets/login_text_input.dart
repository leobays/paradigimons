import 'package:flutter/material.dart';

class LoginTextInput extends StatefulWidget {

  final Icon icon;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;

  LoginTextInput({
    @required this.icon, 
    @required this.labelText, 
    @required this.hintText,
    @required this.keyboardType
  });

  @override
  _LoginTextInputState createState() => _LoginTextInputState(
      hintText: hintText,
      icon: icon,
      labelText: labelText,
      keyboardType: keyboardType,
  );
}

class _LoginTextInputState extends State<LoginTextInput> {

  LoginTextInput loginTextInput;
  
  final Icon icon;
  final String labelText;
  final String hintText;
  bool obscure = true;
  final TextInputType keyboardType;


  _LoginTextInputState({
    @required this.icon, 
    @required this.labelText, 
    @required this.hintText,
    @required this.keyboardType,
  });
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        labelText: labelText,
        hintText: hintText,
        suffixIcon: _checkSuffix() ? 
          obscure ?
            IconButton(
              icon: Icon(Icons.visibility_off), 
              onPressed: (){  
                _toggleVisibility();
              }
            ): 
            IconButton(
              icon: Icon(Icons.visibility), 
              onPressed: (){  
                _toggleVisibility();
              }
            ) : null
      ),
      keyboardType: keyboardType,
      obscureText: _checkSuffix() ? obscure : false,
    );
  }

  void _toggleVisibility(){
    setState(() {
      obscure = !obscure;
    });
  }

  bool _checkSuffix() => labelText.contains('Password') ? true : false;
}