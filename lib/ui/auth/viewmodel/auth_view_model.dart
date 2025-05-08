import 'package:fixedfundsflows/data/services/authentication_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@Riverpod(keepAlive: false)
class AuthViewModel extends _$AuthViewModel {
  @override
  Future<bool?> build() async {
    final authService = ref.read(authenticationServiceProvider);
    final bool success = await authService.authenticate();
    return success;
  }

  Future<bool?> authenticate() async {
    try {
      final authService = ref.read(authenticationServiceProvider);
      final success = await authService.authenticate();
      state = AsyncValue.data(success);
      return success;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}
