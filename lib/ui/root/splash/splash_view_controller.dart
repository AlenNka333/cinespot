import 'package:cinespot/core/app_style.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:cinespot/ui/root/splash/cubit/splash_cubit.dart';
import 'package:cinespot/ui/root/splash/cubit/splash_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashViewController extends StatelessWidget {
  const SplashViewController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
        listenWhen: (previous, current) {
      return previous.status == SplashStatus.loading &&
          current.status != SplashStatus.loading;
    }, listener: (context, state) {
      final route = state.status == SplashStatus.authorized
          ? AppRouter.homePage
          : AppRouter.loginPage;
      Navigator.of(context).pushNamed(route);
    }, child: BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        if (state.status == SplashStatus.loading) {
          return CupertinoPageScaffold(
            backgroundColor: AppStyle.appTheme.scaffoldBackgroundColor,
            child: Center(
              child: Image(image: AssetImage("assets/cinespot_logo.png")),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    ));
  }
}
