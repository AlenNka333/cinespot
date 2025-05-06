import 'package:bloc/bloc.dart';
import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/ui/root/splash/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthenticationManager _authManager;

  SplashCubit(this._authManager) : super(SplashState.initial());

  Future<void> checkAuthorization() async {
    emit(const SplashState(status: SplashStatus.loading));

    try {
      final bool isAuthorized = await _authManager.checkUserSession();
      emit(SplashState(
          status: isAuthorized
              ? SplashStatus.authorized
              : SplashStatus.unauthorized));
    } catch (error) {
      print('Authorization failed: $error');
      emit(SplashState(status: SplashStatus.unauthorized));
    }
  }
}
