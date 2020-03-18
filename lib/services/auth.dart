import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){ //turn a FirebaseUser into User type
    return user != null ? User(uid: user.uid) : null;
  }

  //match with StreamProvider<User> type
  Stream<User> get user{ //it is a getter named "user"
    return _auth.onAuthStateChanged //pass the FirebaseUser object into a function, change the object to User
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  Future register(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateUserData('user', 'NA', 18);
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
      return _userFromFirebaseUser(user);
    }catch (e){
      print(e.toString());
      return null;
    }
  }
}