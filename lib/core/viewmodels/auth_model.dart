import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucento/core/base/base_view_model.dart';
import 'package:lucento/core/enums/view_state.dart';
import 'package:lucento/core/errors/failures.dart';
import 'package:lucento/core/models/user.dart';
import 'package:lucento/core/services/auth_service.dart';
import 'package:lucento/locator.dart';
import 'package:lucento/core/utils/extensions/task_extenstion.dart';

class AuthModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  AuthModel() {
    getCurrentUser();
  }
  Either<Failure, User> _user;
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Either<Failure, User> get user => _user;

  User get pureUser =>
      user != null && user.isRight() ? user.getOrElse(null) : null;

  Future<void> signIn(String email, String password) async {
    setState(ViewState.loading);
    await Task(() => _authService.signInWithEmailAndPassword(email, password))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((failureOrUser) => _user = failureOrUser);
    setState(ViewState.loaded);
  }

  Future<Either<Failure, void>> sendForgotPasswordEmail(String email) async {
    setState(ViewState.loading);
    Either<Failure, void> result =
        await Task(() => _authService.sendForgotPasswordEmail(email))
            .attempt()
            .mapLeftToFailure()
            .run();
    setState(ViewState.loaded);
    return result;
  }

  Future<void> signUp(User user, String password) async {
    setState(ViewState.loading);
    await Task(() => _authService.signUpWithEmailAndPassword(user, password))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((failureOrUser) => _user = failureOrUser);
    setState(ViewState.loaded);
  }

  Future<void> signOut() async {
    setState(ViewState.loading);
    await _authService.signOut();
    _user = null;
    setState(ViewState.loaded);
  }

  void getCurrentUser() async {
    setState(ViewState.loading);
    await Task(() => _authService.currentUser)
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((failureOrUser) => _user = failureOrUser);
    setState(ViewState.loaded);
  }
}
