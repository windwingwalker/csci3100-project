import 'package:csci3100/routing/bottombar.dart';
import 'package:csci3100/views/auth/forgot_password.dart';
import 'package:csci3100/views/auth/register.dart';
import 'package:csci3100/views/chat/chat_room.dart';
import 'package:csci3100/views/init/description.dart';
import 'package:csci3100/views/init/self_info.dart';
import 'package:csci3100/views/init/target.dart';
import 'package:csci3100/views/setting/account.dart';
import 'package:csci3100/views/setting/discover.dart';
import 'package:csci3100/views/setting/notification.dart';
import 'package:csci3100/views/setting/setting.dart';
import 'package:csci3100/views/profile/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/routing/wrapper.dart';
import 'package:csci3100/views/chat/chat.dart';
import 'package:csci3100/views/profile/profile.dart';
import 'package:csci3100/views/auth/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => Wrapper());
      case '/chat':
        return MaterialPageRoute(builder: (_) => Chat());
      case '/chatroom':
        return MaterialPageRoute(builder: (_) => ChatRoom());
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
      case '/bottombar':
        return MaterialPageRoute(builder: (_) => BottomBar());
      case '/self_info':
        return MaterialPageRoute(builder: (_) => Basic());
      case '/target_info':
        return MaterialPageRoute(builder: (_) => Target());
      case '/desc':
        return MaterialPageRoute(builder: (_) => Description());
      case '/account':
        return MaterialPageRoute(builder: (_) => Account());
      case '/notification':
        return MaterialPageRoute(builder: (_) => Notifications());
      case '/discover':
        return MaterialPageRoute(builder: (_) => Discover());
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