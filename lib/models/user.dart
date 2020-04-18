class User{
  final String uid;
  final String name;
  final String college;
  final double age;
  final String gender;
  final bool firstLogin;
  final bool liked;

  User({this.uid, this.name, this.age, this.gender, this.college, this.firstLogin, this.liked});
}

class UserData{
  final String uid;
  final String name;
  final String college;
  final double age;
  final bool firstLogin;

  UserData({this.uid, this.name, this.age, this.college, this.firstLogin});
}