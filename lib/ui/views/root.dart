import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:lucento/core/enums/view_state.dart';

import 'package:lucento/core/viewmodels/auth_model.dart';
import 'package:lucento/ui/views/auth/auth_home_screen.dart';
import 'package:lucento/ui/views/home/home_screen.dart';
import 'package:lucento/ui/views/splash_screen.dart';

class RootScreen extends StatelessWidget {
  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AuthModel>(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: model.state == ViewState.loading
          ? SplashScreen()
          : model.pureUser == null ? AuthHomeScreen() : HomeScreen(),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Press back again to exit.");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
