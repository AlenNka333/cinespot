import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';
part 'splash_event.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthenticationManager _authManager;

  SplashBloc(this._authManager) : super(SplashInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  void _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<SplashState> emit) async {
    emit(AuthorizationProcessing());

    try {
      final bool isAuthorized = await _authManager.checkUserSession();
      isAuthorized ? emit(Authorized()) : emit(Unauthorized());
    } catch (error) {
      emit(AuthorizationStatusFailed(error.toString()));
    }
  }
}
