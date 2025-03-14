import 'package:flutter/material.dart';
import 'package:hichat/core/constants/strings.dart';
import 'package:hichat/core/models/user_model.dart';
import 'package:hichat/ui/screens/auth/login/login_screen.dart';
import 'package:hichat/ui/screens/auth/signup/signup_screen.dart';
import 'package:hichat/ui/screens/bottom_navigation/chat_list/chat_room/chat_screen.dart';
import 'package:hichat/ui/screens/wrapper/wrapper.dart';

import '../../ui/screens/splashScreen/splash_screen.dart';

class RouteUtils {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      //  case home:
      //   return MaterialPageRoute(builder: (context) => const HomeScreen());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case wrapper:
        return MaterialPageRoute(builder: (context) => const Wrapper());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case chatRoom:
        return MaterialPageRoute(
            builder: (context) => ChatScreen(
                  receiver: args as UserModel,
                ));

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text(" No Route Found")),
                ));
    }
  }
}
