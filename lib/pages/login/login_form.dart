import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:future/connection/firebase_connection.dart';
import 'package:future/navigation_bottom/main_page.dart';
import 'package:future/pages/login/bloc/login_bloc.dart';
import 'package:future/pages/register/register_page.dart';
import 'package:future/pages/revovery/recovery_page.dart';
import 'package:future/util/border_inputs.dart';
import 'package:future/util/change_focus.dart';
import 'package:future/util/email_validation.dart';
import 'package:future/util/password_validation.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  String _email;
  String _password;

  LoginBloc bloc = LoginBloc();
  ConnectionWithFirebase _auth = ConnectionWithFirebase();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _emailInput(),
              SizedBox(height:10),
              _passwordInput(),
              Padding(
                padding: EdgeInsets.only(top: 16), 
                child: _confirmFormButton(),
              ),
              SizedBox(height:10),
              _failLogin(),
              Padding(
                padding: EdgeInsets.only(top:40),
                child: Center(
                  child:RichText(
                    text: TextSpan(
                      text: 'Doesn\'t have account? ',
                      style: TextStyle(fontSize: 16,color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign up', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) => RegisterPage()
                              )
                              ).then((_){
                                _passwordController.clear();
                                _emailController.clear();
                              });
                            }
                        ),
                        TextSpan(text: ' right now!'),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32,bottom: 16),
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
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => RecoveryPage()
                              )); 
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

  void navigatorTo(BuildContext context, user){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => MainPage(user: user),
    ));
  }

  bool _validateForm(){
    if (_formKey.currentState.validate()){
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  Widget _emailInput(){
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: 'Login',
        hintText: 'exemple@exemple.com',
        border: BorderInputs().borderStyle(),
      ),
      cursorColor: Colors.black,
      focusNode: _emailFocus,
      validator: (String value){
        return EmailValidation().emailValidation(value);
      },
      onSaved: (String value){
        _email = value;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) => ChangeFocusForm().changeFocus(context, _emailFocus, _passwordFocus),
    );
  }

  Widget _confirmFormButton(){
    return SizedBox(
      width: double.maxFinite,
      height: 45,
      child: RaisedButton(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.white,
        textColor: Colors.black,
        child:Text('Sign in',style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () async {
          _formKey.currentState.reset();
          FocusScope.of(context).requestFocus(FocusNode());
          if (_validateForm()) {
            dynamic result = await _auth.signIn(_email, _password);
            if (result != null){
              bloc.inputError.add('');
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => MainPage(user: result),
              ));
            }else {
              bloc.inputError.add('Failt to connect with this user, please verify your credentials.'); 
            }
          } 
        },
      ),
    );
  }

  Widget _failLogin(){
    return StreamBuilder<Object>(
      stream: bloc.outputError,
      initialData: '',
      builder: (context, snapshot) {
        return Container(
          color: Colors.red,
          child: Text(
            snapshot.data.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white
            ),
          ),
        );
      }
    );
  }

  Widget _passwordInput(){
    return StreamBuilder<Object>(
      initialData: true,
      stream: bloc.output,
      builder: (context, snapshot) {
        return TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            border: BorderInputs().borderStyle(),
            icon: Icon(Icons.vpn_key),
            labelText: 'Password',
            hintText: 'Type your password',
            suffixIcon: IconButton(
              icon: snapshot.data ? Icon(Icons.visibility_off) : Icon(Icons.visibility), 
              onPressed: (){  
                bloc.toggleVisibility();
              }
            )
          ),
          cursorColor: Colors.black,
          validator: (String value){
            return PasswordValidation().validatePassword(value);
          },
          onSaved: (String value){
            _password = value;
          },
          focusNode: _passwordFocus,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          obscureText: snapshot.data ? snapshot.data : false,
        );
      }
    );
  }
}

