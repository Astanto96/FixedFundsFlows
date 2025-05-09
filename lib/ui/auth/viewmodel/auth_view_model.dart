import 'package:fixedfundsflows/application/services/app_start_service.dart';
import 'package:fixedfundsflows/data/services/authentication_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@Riverpod(keepAlive: false)
class AuthViewModel extends _$AuthViewModel {
  @override
  Future<bool?> build() async {
    try {
      final appService = ref.read(appStartServiceProvider);
      await appService.initializeHive();
      await appService.initializeAppIfNeeded();

      final authService = ref.read(authenticationServiceProvider);
      final bool success = await authService.authenticate();
      return success;
    } catch (e, st) {
      return Future.error(e, st);
    }
  }

  Future<bool?> authenticate() async {
    if (state.asData?.value == true) return true; // schon erfolgreich

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
