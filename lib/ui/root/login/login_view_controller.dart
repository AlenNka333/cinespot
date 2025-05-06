import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/ui/root/login/bloc/login_bloc.dart';
import 'package:cinespot/ui/root/login/widgets/login_form.dart';
import 'package:cinespot/utils/app_style.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewController extends StatelessWidget {
  const LoginViewController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(context.read<AuthenticationManager>()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushReplacementNamed(AppRouter.homePage);
          }

          if (state is LoginFailed) {
            showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                      title: const Text('Login Error'),
                      content: Text(state.error),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ));
          }
        },
        builder: (context, state) {
          return CupertinoPageScaffold(
            backgroundColor: AppStyle.appTheme.scaffoldBackgroundColor,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(119, 127, 194, 1),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: const LoginForm()),
              ),
            ),
          );
        },
      ),
    );
  }
}
