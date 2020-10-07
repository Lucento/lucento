import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucento/core/services/auth_service.dart';
import 'package:lucento/core/services/user_service.dart';
import 'package:lucento/core/viewmodels/auth_model.dart';

import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //! External
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => Firestore.instance);

  // Services
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserService());

  // ViewModels
  locator.registerFactory(() => AuthModel());
}
