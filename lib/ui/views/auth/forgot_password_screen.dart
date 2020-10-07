import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucento/core/enums/view_state.dart';
import 'package:lucento/core/viewmodels/auth_model.dart';
import 'package:lucento/ui/utils/colors.dart';
import 'package:lucento/ui/validators/auth_validators.dart';
import 'package:lucento/ui/widgets/custom_button.dart';
import 'package:lucento/ui/widgets/showError.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordScreenScaffoldKey = GlobalKey<ScaffoldState>();
  final _signInFormKey = GlobalKey<FormState>();

  bool isSentLink = false;
  int sentCount = 0;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AuthModel>(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: _forgotPasswordScreenScaffoldKey,
          body: Container(
            height: double.infinity,
            child: Stack(
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
                    "Forgot Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // SizedBox(height: 30),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 70),
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
                          Container(
                            child: model.state == ViewState.loading
                                ? CircularProgressIndicator()
                                : CustomButton(
                                    width: 300,
                                    height: 60,
                                    onPressed: () =>
                                        _sendPasswordResetMail(model),
                                    child: Text(
                                      !isSentLink ? "Send" : "Re send",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                          ),
                          AnimatedOpacity(
                            opacity: isSentLink ? 1 : 0,
                            duration: Duration(milliseconds: 500),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Password reset link was sent to the ${model.emailController.text}, Please RESET your password there.",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                FlatButton(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 32,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Login Now",
                                    style: TextStyle(
                                      color: ThemeColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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

  void _sendPasswordResetMail(AuthModel model) async {
    if (sentCount < 3) {
      if (!_signInFormKey.currentState.validate()) return;
      setState(() => isSentLink = false);
      // final result = "";
      final result =
          await model.sendForgotPasswordEmail(model.emailController.text);
      result.fold(
          (failure) => showError(
              _forgotPasswordScreenScaffoldKey.currentState, failure.message),
          (right) => setState(() {
                isSentLink = true;
                sentCount++;
              }));
    } else {
      showError(_forgotPasswordScreenScaffoldKey.currentState,
          "Max Limit reached for re sending the link, Please try again later or contact us.");
    }
  }
}
