import 'package:practical_test/core/utils/data_state.dart';
import 'package:practical_test/features/auth/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<DataState<void>> call() {
    return _authRepository.logout();
  }
}
