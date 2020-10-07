import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:lucento/core/enums/view_state.dart';
import 'package:lucento/core/viewmodels/auth_model.dart';
import 'package:lucento/ui/routers/routes.dart';

class HomeScreen extends StatelessWidget {
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: "Press back again to exit.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AuthModel>(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            IconButton(
              icon: model.pureUser?.uid != null
                  ? Icon(Icons.exit_to_app)
                  : Icon(Icons.person),
              onPressed: () async {
                if (model.pureUser?.uid != null) {
                  await model.signOut();
                }
                Navigator.pushReplacementNamed(context, Routes.authHomeScreen);
              },
            )
          ],
        ),
        body: Center(
          child: model.state == ViewState.loading
              ? CircularProgressIndicator()
              : Text("${model.pureUser?.email}: ${model.pureUser?.role}" ??
                  "Not Logged In!"),
        ),
      ),
    );
  }
}
