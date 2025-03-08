import 'package:flutter/material.dart';
import 'package:hichat/core/constants/strings.dart';
import 'package:hichat/ui/screens/auth/login/login_screen.dart';
import 'package:hichat/ui/screens/auth/signup/signup_screen.dart';
import 'package:hichat/ui/screens/home/home_screen.dart';
import 'package:hichat/ui/screens/wrapper/wrapper.dart';

import '../../ui/screens/splashScreen/splash_screen.dart';

class RouteUtils {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case wrapper:
        return MaterialPageRoute(builder: (context) => const Wrapper());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text(" No Route Found")),
                ));
    }
  }
}
