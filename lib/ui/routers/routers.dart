import 'package:flutter/material.dart';
import 'package:lucento/ui/routers/routes.dart';
import 'package:lucento/ui/views/auth/auth_home_screen.dart';
import 'package:lucento/ui/views/auth/forgot_password_screen.dart';
import 'package:lucento/ui/views/auth/signin_screen.dart';
import 'package:lucento/ui/views/auth/signup_screen.dart';
import 'package:lucento/ui/views/home/home_screen.dart';
import 'package:lucento/ui/views/root.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(builder: (context) => RootScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case Routes.authHomeScreen:
        return MaterialPageRoute(builder: (context) => AuthHomeScreen());
      case Routes.signinScreen:
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
      default:
        return MaterialPageRoute(builder: (context) => RootScreen());
    }
  }
}
