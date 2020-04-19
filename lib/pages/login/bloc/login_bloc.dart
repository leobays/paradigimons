import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:future/model/login_user.dart';

class LoginBloc{

  bool obscure = true;

  final StreamController _streamControllerObscure = StreamController();
  final StreamController<LoginUser> _streamControllerLogin = StreamController<LoginUser>();
  final StreamController<String> _streamControllerErrorLogin = StreamController<String>();

  Sink get input => _streamControllerObscure.sink;
  Stream get output => _streamControllerObscure.stream;

  Sink<LoginUser> get inputLogin => _streamControllerLogin.sink;
  Stream<AuthResult> get outputLogin => _streamControllerLogin.stream.asyncMap((user) => _signIn(user));

  Sink<String> get inputError => _streamControllerErrorLogin.sink;
  Stream<String> get outputError => _streamControllerErrorLogin.stream;


  Future<AuthResult> _signIn(LoginUser user) async{
    AuthResult userAuth = await FirebaseAuth.instance.signInWithEmailAndPassword(email:user.email, password: user.password);
    return userAuth;
  }

  

  toggleVisibility(){
    obscure = !obscure;
    input.add(obscure);
  }
}