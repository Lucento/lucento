import 'package:flutter/material.dart';
import 'package:lucento/ui/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final Widget child;

  const CustomButton(
      {Key key, this.width, this.height, @required this.onPressed, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: ThemeColors.accent,
      minWidth: width ?? double.infinity,
      height: height ?? 50,
      onPressed: onPressed,
      child: child,
    );
  }
}
