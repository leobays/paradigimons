import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{

  @override
  State createState() => LoginPageState();
    
}

class LoginPageState extends State<LoginPage>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(255, 130, 102, 1),
                  Color.fromRGBO(255, 89, 89, 1),
                ]
              )
            ),
            child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Image(
                  image: AssetImage('assets/login_app_foreground.png'),
                  height: 300,
                ),
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
                child: Form(
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.black,
                      accentColor: Colors.black
                    ),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.people),
                            labelText: 'Login',
                            hintText: 'exemple@exemple.com'
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                          icon: Icon(Icons.vpn_key),
                            labelText: 'Password',
                            hintText: 'Type your password'
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16), 
                          child: SizedBox(
                            width: double.maxFinite,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              color: Colors.white,
                              textColor: Color.fromRGBO(255, 89, 89, 1),
                              child:Text('LOGIN',style: TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: (){
                                print('clicou no botao');
                              }
                            ),
                          )
                        ),
                      ]
                    ),
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.only(top:24),
                child: Center(
                  child:RichText(
                    text: TextSpan(
                      text: 'Doesn\'t have account? ',
                      style: TextStyle(fontSize: 16,color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('implementar tela de cadastro');
                            }
                        ),
                        TextSpan(text: ' right now!'),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 64),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text:'Forgot ',
                      style: TextStyle(fontSize: 16,color: Colors.black),
                      children: <TextSpan>[
                         TextSpan(
                          text: 'Password?', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('implementar tela de recuperar senha');
                            }
                        ),
                      ]
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

