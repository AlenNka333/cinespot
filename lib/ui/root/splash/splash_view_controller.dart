import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/ui/root/splash/bloc/splash_bloc.dart';
import 'package:cinespot/utils/app_style.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashViewController extends StatelessWidget {
  const SplashViewController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(context.read<AuthenticationManager>())
        ..add(CheckAuthStatus()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is Authorized) {
            Navigator.of(context).pushReplacementNamed(AppRouter.homePage);
          } else if (state is Unauthorized) {
            Navigator.of(context).pushReplacementNamed(AppRouter.loginPage);
          }
        },
        child: CupertinoPageScaffold(
          backgroundColor: AppStyle.appTheme.scaffoldBackgroundColor,
          child: Center(
            child: Image(image: AssetImage("assets/cinespot_logo.png")),
          ),
        ),
      ),
    );
  }
}
