import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:lucento/core/errors/error_codes/firebase_auth_error_code.dart';
import 'package:lucento/core/errors/error_messages.dart';
import 'package:lucento/core/errors/errors.dart';
import 'package:lucento/core/errors/failures.dart';
import 'package:lucento/core/models/user.dart';
import 'package:lucento/core/services/user_service.dart';
import 'package:lucento/locator.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();
  final UserService _userService = locator<UserService>();

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userService.getUser(result.user.uid);
    } on PlatformException catch (e) {
      print("PlatformException[FirebaseAuthError]: ${e.code}");
      switch (e.code) {
        case FirebaseAuthErrorCode.INVALID_EMAIL:
          throw InputError(message: "Invalid email address!");
        case FirebaseAuthErrorCode.WRONG_PASSWORD:
          throw InputError(message: "Invalid password!");
        case FirebaseAuthErrorCode.USER_NOT_ALLOWED:
          throw InputError(message: "User is not allowed!");
        case FirebaseAuthErrorCode.NO_USER_FOUND:
          throw InputError(message: "No user found, try sign up insted!");
        case FirebaseAuthErrorCode.NETWORK_ERROR:
          throw NeworkFailure(
            message: "Make sure you connected with the internet!",
          );
        default:
          throw Failure(message: ErrorMessages.unknownError);
      }
    } on Failure {
      rethrow;
    }
  }

  Future<User> signUpWithEmailAndPassword(User user, password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      await _userService.createUser(result.user.uid, user);
      return currentUser;
    } on PlatformException catch (e) {
      print("PlatformException[FirebaseAuthError]: ${e.code}");
      switch (e.code) {
        case FirebaseAuthErrorCode.INVALID_EMAIL:
          throw InputError(message: "Invalid Email Address!");
        case FirebaseAuthErrorCode.WEAK_PASSWORD:
          throw InputError(
              message: "Password must be atleast of 6 characters!");
        case FirebaseAuthErrorCode.EMAIL_ALREADY_IN_USE:
          throw InputError(
              message: "User is already exists, please try to sign in!");
        case FirebaseAuthErrorCode.NETWORK_ERROR:
          throw NeworkFailure(
            message: "Make sure you connected with the internet!",
          );
        default:
          throw Failure(message: ErrorMessages.unknownError);
      }
    } on Failure {
      rethrow;
    }
  }

  Future<void> sendForgotPasswordEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      print("PlatformException[FirebaseAuthError]: ${e.code}");
      switch (e.code) {
        case FirebaseAuthErrorCode.INVALID_EMAIL:
          throw InputError(message: "Invalid Email Address!");
        case FirebaseAuthErrorCode.NO_USER_FOUND:
          throw InputError(message: "No user found, try sign up insted!");
        case FirebaseAuthErrorCode.NETWORK_ERROR:
          throw NeworkFailure(
            message: "Make sure you connected with the internet!",
          );
        default:
          throw Failure(message: ErrorMessages.unknownError);
      }
    } catch (e) {
      print(e.toString());
      throw Failure(message: ErrorMessages.unknownError);
    }
  }

  Future<User> get currentUser async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user == null ? null : _userService.getUser(user.uid);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
