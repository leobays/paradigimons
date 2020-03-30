import 'package:flutter/material.dart';
import 'package:future/widgets/login_text_input.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 89, 89, 1),
        automaticallyImplyLeading: false,
        title: Center(child: Text('Register'))
      ),
      body: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.black,
                    accentColor: Colors.black,
                  ),
                  child: Column(
                      children: <Widget>[
                        Container(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                LoginTextInput(
                          icon: Icon(Icons.people), 
                          labelText: 'Name', 
                          hintText: 'Type your name',
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        LoginTextInput(
                          icon: Icon(Icons.email), 
                          labelText: 'E-mail', 
                          hintText: 'Type your e-mail',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        LoginTextInput(
                          icon: Icon(Icons.vpn_key), 
                          labelText: 'Password', 
                          hintText: 'Type your Password',
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        LoginTextInput(
                          icon: Icon(Icons.vpn_key), 
                          labelText: 'Confirm Password', 
                          hintText: 'Type again your Password',
                          keyboardType: TextInputType.visiblePassword,
                        ),
                              ]
                            )
                          )
                        ),
                        
                        Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: SizedBox(
                            width: double.maxFinite,
                            height: 45,
                            child: RaisedButton(
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              textColor: Color.fromRGBO(255, 89, 89, 1),
                              color: Colors.black,
                              child: Text('Confirm'),
                              onPressed: (){print('Implementar voltar ao menu');}
                            ),
                          ),
                        )
                      ],
                    ),
                ),
              ),
            ],
          ),
        ),
        //color: Color.fromRGBO(255, 130, 102, 0.8),
      ),
    );
  }
}
