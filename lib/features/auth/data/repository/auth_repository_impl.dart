import 'package:firebase_auth/firebase_auth.dart';
import 'package:practical_test/core/utils/data_state.dart';
import 'package:practical_test/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _auth;

  AuthRepositoryImpl(this._auth);

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<DataState<UserCredential>> signInWithGoogle() async {
    try {
      final auth = await _auth.signInWithProvider(GoogleAuthProvider());
      return DataSuccess(auth);
    } on FirebaseAuthException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserCredential>> signInWithFacebook() async {
    try {
      final auth = await _auth.signInWithProvider(FacebookAuthProvider());
      return DataSuccess(auth);
    } on FirebaseAuthException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> logout() async {
    try {
      final auth = await _auth.signOut();
      return (DataSuccess(null));
    } on FirebaseAuthException catch (e) {
      return DataFailed(e);
    }
  }
}
