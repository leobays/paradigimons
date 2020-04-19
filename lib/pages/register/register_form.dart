import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future/util/border_inputs.dart';
import 'package:future/util/change_focus.dart';
import 'package:future/util/email_validation.dart';
import 'package:future/util/password_validation.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  String _email;
  String _password;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

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
              SizedBox(height:10),
              _passwordInput(),
              SizedBox(height:10),
              _confirmPasswordInput(),
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 32),
                child: _confirmSignUpForm(),
              )
            ],
          ),
        ),
      ),
    );
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
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) => ChangeFocusForm().changeFocus(context, _emailFocus, _passwordFocus),
    );
  }

  Widget _confirmSignUpForm(){
    return SizedBox(
      width: double.maxFinite,
      height: 45,
      child: RaisedButton(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textColor: Colors.black,
        child: Text('Confirm'),
        onPressed: (){
         _signUp();
        }
      ),
    );
  }

  Widget _passwordInput(){
    return TextFormField(
      decoration: InputDecoration(
        border: BorderInputs().borderStyle(),
        icon: Icon(Icons.vpn_key),
        labelText: 'Password',
        hintText: 'Type your password.',
        suffixIcon: IconButton(
          icon: _obscurePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility), 
          onPressed: (){  
            _toggleVisibilityPassword();
          }
        )
      ),
      cursorColor: Colors.black,
      controller: _passwordController,
      focusNode: _passwordFocus,
      validator: (String value) =>
        PasswordValidation().passwordLength(value.length),
      onSaved: (String value){
        _password = value;
      },
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscurePassword ? true : false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) => ChangeFocusForm().changeFocus(context, _passwordFocus, _confirmPasswordFocus),
    );
  }

  Widget _confirmPasswordInput(){
    return TextFormField(
      decoration: InputDecoration(
        border: BorderInputs().borderStyle(),
        icon: Icon(Icons.vpn_key),
        labelText: 'Confirm Password',
        hintText: 'Type your password again.',
        suffixIcon: IconButton(
          icon: _obscureConfirmPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility), 
          onPressed: (){  
            _toggleVisibilityConfirmPassword();
          }
        )
      ),
      cursorColor: Colors.black,
      controller: _confirmPasswordController,
      focusNode: _confirmPasswordFocus,
      validator: (String value) {
        return PasswordValidation().passwordLenghtAndEqual(value.length, _passwordController.text, _confirmPasswordController.text);
      },
      obscureText: _obscureConfirmPassword ? true : false,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    ); 
  }

  // String tste(String value) {
  //   String that;
  //   that = PasswordValidation().passwordLength(value.length);
  //   if (that != null) return that;
  //   that = PasswordValidation().passwordEqual(_passwordController.text, _confirmPasswordController.text);
  //   return that;
  // }

  void _toggleVisibilityConfirmPassword(){
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _toggleVisibilityPassword(){
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _signUp() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try {
        AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        //user.emailVerification()
        Navigator.of(context).pop();
      } catch (e) {
        print(e.message);
      }
    }
  }

}