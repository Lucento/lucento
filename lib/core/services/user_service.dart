import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lucento/core/config.dart';
import 'package:lucento/core/errors/failures.dart';
import 'package:lucento/core/models/user.dart';
import 'package:lucento/locator.dart';

class UserService {
  final Firestore _firestore = locator<Firestore>();

  Future<User> getUser(String uid) async {
    try {
      final snapshot = await _firestore
          .collection(FireStoreCollections.users)
          .document(uid)
          .get();
      return User.fromDocumentSnapshot(snapshot);
    } catch (e) {
      print(e.toString());
      throw Failure(message: "Somthing is wrong, please try again later!");
    }
  }

  Future<void> createUser(String uid, User user) async {
    try {
      await _firestore
          .collection(FireStoreCollections.users)
          .document(uid)
          .setData(user.toJSON);
    } catch (e) {
      print(e.toString());
      throw Failure(message: "Somthing is wrong, please try again later!");
    }
  }
}
