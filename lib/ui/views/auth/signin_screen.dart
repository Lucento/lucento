import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucento/core/enums/view_state.dart';
import 'package:lucento/core/viewmodels/auth_model.dart';
import 'package:lucento/ui/routers/routes.dart';
import 'package:lucento/ui/utils/colors.dart';
import 'package:lucento/ui/validators/auth_validators.dart';
import 'package:lucento/ui/widgets/custom_button.dart';
import 'package:lucento/ui/widgets/showError.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInScreenScaffoldKey = GlobalKey<ScaffoldState>();
  final _signInFormKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AuthModel>(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: _signInScreenScaffoldKey,
          body: SingleChildScrollView(
            child: Column(
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
                    "Welcome back!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: model.emailController,
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
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 45, right: 45),
                  child: model.state == ViewState.loading
                      ? CircularProgressIndicator()
                      : CustomButton(
                          // width: 300,
                          height: 60,
                          onPressed: () => _signIn(model),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                SizedBox(height: 10),
                FlatButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.forgotPasswordScreen),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(color: ThemeColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn(AuthModel model) async {
    if (!_signInFormKey.currentState.validate()) return;
    await model.signIn(model.emailController.text, _passwordController.text);
    model.user.fold(
        (failure) =>
            showError(_signInScreenScaffoldKey.currentState, failure.message),
        (user) => Navigator.pushNamedAndRemoveUntil(
            context, Routes.root, (routes) => false));
  }
}
