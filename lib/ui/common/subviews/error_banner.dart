import 'package:cinespot/data/handlers/error_handler_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorHandlerCubit, String?>(
      listenWhen: (previous, current) => current != null,
      listener: (context, message) {
        Future.delayed(const Duration(seconds: 3), () {
          context.read<ErrorHandlerCubit>().clear();
        });
      },
      child: BlocBuilder<ErrorHandlerCubit, String?>(
        builder: (context, message) {
          if (message == null) return const SizedBox.shrink();

          return Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              bottom: false,
              child: Container(
                padding: const EdgeInsets.only(
                    top: 60, bottom: 20, left: 20, right: 20),
                color: CupertinoColors.systemRed,
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
