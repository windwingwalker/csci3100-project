import 'package:csci3100/views/auth/forgot_password.dart';
import 'package:csci3100/views/auth/register.dart';
import 'package:csci3100/views/setting/setting.dart';
import 'package:csci3100/views/setting/system.dart';
import 'package:csci3100/views/setting/upload_image.dart';
import 'package:csci3100/views/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/routing/wrapper.dart';
import 'package:csci3100/views/chat/chat.dart';
import 'package:csci3100/views/setting/profile.dart';
import 'package:csci3100/views/auth/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => Wrapper());
      case '/chat':
        return MaterialPageRoute(builder: (_) => Chat());
      case '/setting':
        return MaterialPageRoute(builder: (_) => Setting());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/image_upload':
        return MaterialPageRoute(builder: (_) => ImageCapture());
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case '/system':
        return MaterialPageRoute(builder: (_) => System());
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