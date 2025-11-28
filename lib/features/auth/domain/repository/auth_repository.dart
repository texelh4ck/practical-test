import 'package:firebase_auth/firebase_auth.dart';
import 'package:practical_test/core/utils/data_state.dart';

abstract class AuthRepository {
  User? get currentUser;
  Future<DataState<void>> logout();
  Future<DataState<UserCredential>> signInWithGoogle();
  Future<DataState<UserCredential>> signInWithFacebook();
}
