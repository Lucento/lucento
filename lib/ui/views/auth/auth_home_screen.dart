import 'package:flutter/material.dart';
import 'package:lucento/ui/routers/routes.dart';
import 'package:lucento/ui/utils/colors.dart';
import 'package:lucento/ui/widgets/custom_button.dart';

class AuthHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Skip",
              style: TextStyle(color: ThemeColors.primary),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.homeScreen);
            },
          )
        ],
      ),
      backgroundColor: ThemeColors.grey,
      body: Container(
        alignment: Alignment.bottomCenter,
        color: ThemeColors.grey,
        height: data.height,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: data.height * 0.45,
              width: data.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 20),
                    color: Colors.black12,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 40),
                  CustomButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.signinScreen),
                    width: data.width * 0.6,
                    child: Text(
                      "Login",
                      style: theme.primaryTextTheme.button,
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.signupScreen),
                    width: data.width * 0.6,
                    child: Text(
                      "Sign up",
                      style: theme.primaryTextTheme.button,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -60,
              left: data.width * 0.5 - 50,
              child: Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ThemeColors.primary,
                ),
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
