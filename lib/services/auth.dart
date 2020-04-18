import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //turn a FirebaseUser into User type
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //create a stream, when user state updated, get the new user
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser); //FirebaseUser -> User
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return 0;
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  Future signUp(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await user.sendEmailVerification();
      await DatabaseService(uid: user.uid).setFirst();
      return _userFromFirebaseUser(user);
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async{ //AuthResult -> FirebaseUser -> User
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      /*if (user.isEmailVerified)
        return _userFromFirebaseUser(user);
      else
        return null;*/
      return _userFromFirebaseUser(user);
    }catch (e){
      print(e.toString());
      return null;
    }
  }
}