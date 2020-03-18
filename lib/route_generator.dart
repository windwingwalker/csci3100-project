import 'package:flutter/material.dart';
import 'package:csci3100/main.dart';
import 'package:csci3100/views/home.dart';
import 'package:csci3100/views/chat/chat_room_list.dart';
import 'package:csci3100/routing/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => Wrapper());
      case '/chatRoomList':
        return MaterialPageRoute(builder: (_) => ChatRoomList());
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