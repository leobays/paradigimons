import 'package:flutter/material.dart';
import 'package:future/pages/login/login_form.dart';


class LoginPage extends StatefulWidget{

  @override
  State createState() => LoginPageState();
    
}

class LoginPageState extends State<LoginPage>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color.fromRGBO(248,248,255, 1)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/login_app_foreground.png'),
                  height: 300,
                ),
                Center(
                  child:RichText(
                    text: TextSpan(
                      text: 'A simple ',
                      style: TextStyle(fontSize: 24,color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: 'Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48)),
                        TextSpan(text: ' page!'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right:16,top: 8),
                  child: Column(
                    children: <Widget>[
                       LoginForm(),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

