import 'package:cinespot/core/app_style.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:cinespot/ui/root/splash/splash_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SplashViewController extends StatelessWidget {
  const SplashViewController({super.key});

  @override
  Widget build(BuildContext context) {
    final splashViewModel =
        Provider.of<SplashViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashViewModel.checkAuthorization();
    });

    return Consumer<SplashViewModel>(builder: (context, viewModel, _) {
      if (viewModel.isLoading) {
        return CupertinoPageScaffold(
          backgroundColor: AppStyle.appTheme.scaffoldBackgroundColor,
          child: Center(
            child: Image(image: AssetImage("assets/cinespot_logo.png")),
          ),
        );
      }

      if (viewModel.isAuthorized == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed(AppRouter.homePage);
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed(AppRouter.loginPage);
        });
      }

      return Container();
    });
  }
}
