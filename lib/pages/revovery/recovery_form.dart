import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future/util/border_inputs.dart';
import 'package:future/util/email_validation.dart';

class RecoveryForm extends StatefulWidget {
  @override
  _RecoveryFormState createState() => _RecoveryFormState();
}

class _RecoveryFormState extends State<RecoveryForm> {

  String _email;
  
  final FocusNode _emailFocus = FocusNode();
  
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: 
        Theme(
          data: ThemeData(
            primaryColor: Colors.black,
            accentColor: Colors.black,
          ),
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height:10),
              _emailInput(),
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 32),
                child: _confirmRecoveryForm(),
              )
            ],
          ),
        )        
      ),
    );
  }

  Widget _confirmRecoveryForm(){
    return SizedBox(
      width: double.maxFinite,
      height: 45,
      child: RaisedButton(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textColor: Colors.black,
        child: Text('Confirm'),
        onPressed: (){
         _sendNotification();
        }
      ),
    );
  }

  Future<void> _sendNotification() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        Navigator.of(context).pop();
      } catch (e) {
        print(e.message);
      }
    }
  }

  Widget _emailInput(){
    return TextFormField(
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
      textInputAction: TextInputAction.done,
    );
  }
}