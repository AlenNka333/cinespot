import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthenticationManager _authManager;
  bool isAuthorized = true;

  ProfileBloc(this._authManager) : super(ProfileInitial()) {
    on<LogoutButtonPressed>(_onLogout);
  }

  void _onLogout(LogoutButtonPressed event, Emitter<ProfileState> emit) {
    isAuthorized = _authManager.logout();
    emit(LogoutSuccess());
  }
}
