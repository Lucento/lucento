import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucento/core/enums/view_state.dart';
import 'package:lucento/core/models/user.dart';
import 'package:lucento/core/viewmodels/auth_model.dart';
import 'package:lucento/ui/routers/routes.dart';
import 'package:lucento/ui/utils/colors.dart';
import 'package:lucento/ui/validators/auth_validators.dart';
import 'package:lucento/ui/widgets/custom_button.dart';
import 'package:lucento/ui/widgets/showError.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final random = Random();

  final _signUpScreenScaffoldKey = GlobalKey<ScaffoldState>();
  final _signUpFormKey = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AuthModel>(context);
    final theme = Theme.of(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: _signUpScreenScaffoldKey,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 70),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: ThemeColors.accent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Text(
                    "Create new account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                controller: _fnameController,
                                validator: emptyValidator,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    InputDecoration(labelText: "First Name"),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                controller: _lnameController,
                                validator: emptyValidator,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    InputDecoration(labelText: "Last Name"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          validator: emailValidator,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: passwordValidator,
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(labelText: "Password"),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (p2) => p2 != _passwordController.text
                              ? "Both password should be same!"
                              : null,
                          controller: _passwordController2,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration:
                              InputDecoration(labelText: "Confirm Password"),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLength: 10,
                          validator: phoneValidator,
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            suffixText: "optional",
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          child: model.state == ViewState.loading
                              ? CircularProgressIndicator()
                              : CustomButton(
                                  height: 60,
                                  onPressed: () => _signUp(model),
                                  child: Text(
                                    "Sign up",
                                    style: theme.primaryTextTheme.button,
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(AuthModel model) async {
    if (!_signUpFormKey.currentState.validate()) return;
    final user = User(
        email: _emailController.text,
        firstName: _fnameController.text,
        lastName: _lnameController.text,
        phone: _phoneController.text);

    await model.signUp(user, _passwordController.text);

    model.user.fold(
        (failure) =>
            showError(_signUpScreenScaffoldKey.currentState, failure.message),
        (user) => Navigator.pushNamedAndRemoveUntil(
            context, Routes.root, (routes) => false));
  }
}
