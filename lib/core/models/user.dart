import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lucento/core/config.dart';

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;

  User({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role = UserRoles.client,
  });
  factory User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    print(snapshot);
    return snapshot != null
        ? User(
            uid: snapshot.documentID,
            firstName: snapshot["firtName"] ?? "",
            lastName: snapshot["lastName"] ?? "",
            email: snapshot["email"] ?? "",
            phone: snapshot["phone"] ?? "",
            role: snapshot["role"] ?? UserRoles.client,
          )
        : null;
  }

  Map<String, dynamic> get toJSON {
    return {
      "firstName": this.firstName,
      "lastName": this.lastName,
      "email": this.email,
      "phone": this.phone,
      "role": this.role,
    };
  }
}
