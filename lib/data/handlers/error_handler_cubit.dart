import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorHandlerCubit extends Cubit<String?> {
  ErrorHandlerCubit() : super(null);

  void showErrorMessage(String message) => emit(message);
  void clear() => emit(null);
}
