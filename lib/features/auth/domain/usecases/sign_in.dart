import 'package:firebase_auth/firebase_auth.dart';
import 'package:practical_test/core/constants/enums.dart';
import 'package:practical_test/core/utils/data_state.dart';
import 'package:practical_test/features/auth/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<DataState<UserCredential>> call(AuthMethod method) async {
    DataState<UserCredential>? auth;
    if (method == AuthMethod.google) {
      auth = await _authRepository.signInWithGoogle();
    }
    if (method == AuthMethod.facebook) {
      auth = await _authRepository.signInWithFacebook();
    }
    return auth ?? DataFailed(Exception("Exception in signin method"));
  }
}
