import 'package:firebase_auth/firebase_auth.dart';
import 'package:future/model/firebase_user.dart';

class ConnectionWithFirebase {

  FirebaseToUser _firebaseToUser(FirebaseUser user){
    return (user != null) ?
      FirebaseToUser(uid: user.uid) : null;
  }

  Future signIn(String _email, String _password) async{
    try {
      AuthResult response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      FirebaseUser user = response.user;
      return _firebaseToUser(user);
    }catch(e){
      print(e);
      return null;
    }
  }
}