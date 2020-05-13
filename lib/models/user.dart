//define user model
class User{
  final String uid;
  final String name;
  final String college;
  final double age;
  final String gender;
  final bool firstLogin;
  final bool liked;
  final int imageNum;
  final String imageIndex;
  final String url;
  final String desc;
  final String targetGender;
  final double targetAgeStart;
  final double targetAgeEnd;
  final bool isActivate;
  final bool isBanned;
  User({this.uid, this.name, this.age, this.isBanned, this.isActivate, this.gender, this.college, this.firstLogin, this.liked, this.imageNum, this.imageIndex, this.url, this.desc, this.targetAgeStart, this.targetAgeEnd, this.targetGender});
}

//define userId model, which is used for the very first current user checking in main.dart
class UserId{
  final String uid;

  UserId({this.uid});
}

class MyUrl{
  final String time;
  final String url;

  MyUrl({this.time, this.url});
}

