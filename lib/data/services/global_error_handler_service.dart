import 'dart:ui';

import 'package:cinespot/data/handlers/error_handler_cubit.dart';
import 'package:flutter/cupertino.dart';

class GlobalErrorHandlerService {
  static final GlobalErrorHandlerService _instance =
      GlobalErrorHandlerService._internal();

  factory GlobalErrorHandlerService() => _instance;

  GlobalErrorHandlerService._internal();

  late ErrorHandlerCubit _cubit;

  void init(ErrorHandlerCubit cubit) {
    _cubit = cubit;

    FlutterError.onError = (FlutterErrorDetails details) {
      _cubit.showErrorMessage(details.exceptionAsString());
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      _cubit.showErrorMessage(error.toString());
      return true;
    };
  }

  void show(String message) {
    _cubit.showErrorMessage(message);
  }

  void clear() {
    _cubit.clear();
  }
}
