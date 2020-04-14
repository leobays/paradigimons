import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:future/pages/navigation_bottom/main_page.dart';
import 'package:future/pages/register/register_page.dart';
import 'package:future/pages/revovery/recovery_page.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  String _email;
  String _password;
  bool _obscure = true;
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
                padding: EdgeInsets.only(top: 48,bottom: 32),
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

  Future<void> signIn() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try {
        AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        print(user.user.email);
        await Navigator.push(context, MaterialPageRoute(
          builder: (context) => MainPage(user: user.user),
        ));
      }catch(e){
      }
    }    
  }

  Widget _emailInput(){
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: 'Login',
        hintText: 'exemple@exemple.com',
        border: _borderStyle(),
      ),
      cursorColor: Colors.black,
      focusNode: _emailFocus,
      validator: (String value){
        return _emailValidation(value);
      },
      onSaved: (String value){
        _email = value;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) => _changeFocus(context, _emailFocus, _passwordFocus),
    );
  }

  String _emailValidation(String value) {
    if (value.isEmpty) return 'E-mail is required';
    if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
    .hasMatch(value)) return 'Invalid e-mail typed';
    return null;
  }

  _changeFocus(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
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
          signIn();
        },
      ),
    );
  }

  Widget _passwordInput(){
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        border: _borderStyle(),
        icon: Icon(Icons.vpn_key),
        labelText: 'Password',
        hintText: 'Type your password',
        suffixIcon: IconButton(
          icon: _obscure ? Icon(Icons.visibility_off) : Icon(Icons.visibility), 
          onPressed: (){  
            _toggleVisibility();
          }
        )
      ),
      
      cursorColor: Colors.black,
      validator: (String value){
        return (value.isEmpty) ? 'Password is required' : null;
      },
      onSaved: (String value){
        _password = value;
      },
      focusNode: _passwordFocus,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      obscureText: _obscure ? _obscure : false,
    );
  }

  void _toggleVisibility(){
    setState(() {
      _obscure = !_obscure;
    });
  }
  
  _borderStyle(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
    );
  }
}

