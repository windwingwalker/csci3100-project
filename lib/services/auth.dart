import 'dart:async';

import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/imagedb.dart';
import 'package:csci3100/services/userdb.dart';
import 'package:firebase_auth/firebase_auth.dart';

//define all authentication methods
class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //turn a FirebaseUser into User
  UserId _userFromFirebaseUser(FirebaseUser user){
    return user != null ? UserId(uid: user.uid) : null;
  }

  //create a stream, when user state updated, get the new user
  Stream<UserId> get userId{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser); //FirebaseUser -> User
  }

  //sign out method
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  //delete account methods
  Future deleteAccount() async{
    try{
      var user = await _auth.currentUser();
      await ImageDB(uid: user.uid).deleteData();
      await UserDB(uid: user.uid).deleteData();
      return user.delete();
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  //reset password method
  Future resetPassword(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch (e){
      print(e.toString());
      return null;
    }
  }


  //sign up method
  Future signUp(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await user.sendEmailVerification();
      await UserDB(uid: user.uid).setFirst();
      return _userFromFirebaseUser(user);
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  //sign in method
  Future signIn(String email, String password) async{
    try{
      //AuthResult -> FirebaseUser -> User
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser fireUser = result.user;

      if (fireUser.isEmailVerified) {
        UserDB(uid: fireUser.uid).updateOneData("lastLogin", DateTime.now().toUtc().toIso8601String().toString());
        ImageDB(uid: fireUser.uid).updateOneData("lastLogin", DateTime.now().toUtc().toIso8601String().toString());
        return _userFromFirebaseUser(fireUser);
      }
      else
        return null;
    }catch (e){
      print(e.toString());
      return null;
    }
  }
}