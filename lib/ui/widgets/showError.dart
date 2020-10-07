import 'package:flutter/material.dart';

void showError(ScaffoldState scaffoldState, String errorMessage) {
  scaffoldState.hideCurrentSnackBar();
  scaffoldState.showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {
          // Navigator.pop(scaffoldState);
        },
      ),
    ),
  );
}
