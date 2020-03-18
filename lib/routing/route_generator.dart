import 'package:flutter/material.dart';
import 'package:csci3100/main.dart';
import 'package:csci3100/views/home.dart';
import 'package:csci3100/views/chat/chat_room_list.dart';
import 'package:csci3100/routing/wrapper.dart';
import 'package:csci3100/models/user.dart';
import 'package:csci3100/views/chat/chat.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    //final user = Provider.of<User>(context);
    print("hi");
    print(settings);

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => Wrapper());
      case '/chat':
        return MaterialPageRoute(builder: (_) => Chat());
      case '/setting':
        return MaterialPageRoute(builder: (_) => )
      default:
        return _errorRoute();


    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}