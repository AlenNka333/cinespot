import 'package:cinespot/ui/common/subviews/error_banner.dart';
import 'package:cinespot/ui/root/favourites/bloc/favourites_bloc.dart';
import 'package:cinespot/ui/root/home/bloc/home_bloc.dart';
import 'package:cinespot/utils/app_style.dart';
import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/ui/common/tab_bar/tab_bar_view_model.dart';
import 'package:cinespot/ui/root/favourites/favourites_view_controller.dart';
import 'package:cinespot/ui/root/home/home_view_controller.dart';
import 'package:cinespot/ui/root/profile/profile_view_controller.dart';
import 'package:cinespot/ui/root/search/search_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CupertinoTabBarApp extends StatelessWidget {
  const CupertinoTabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TabBarViewModel(),
      child: CupertinoApp(
        theme: AppStyle.appTheme,
        home: TabBarController(),
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              const ErrorBanner(),
            ],
          );
        },
      ),
    );
  }
}

class TabBarController extends StatelessWidget {
  const TabBarController({super.key});

  @override
  Widget build(BuildContext context) {
    final TabBarViewModel viewModel = Provider.of<TabBarViewModel>(context);

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: viewModel.getCurrentIndex,
        onTap: (value) => viewModel.setCurrentIndex(value),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart_circle_fill),
              label: "Favourites"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled), label: "Profile"),
        ],
      ),
      tabBuilder: (context, index) {
        if (index == 0) {
          return CupertinoTabView(builder: (context) {
            return BlocProvider(
              create: (context) => HomeBloc()..add(LoadInitialData()),
              child: HomeViewController(),
            );
          });
        } else if (index == 1) {
          return CupertinoTabView(
              builder: (context) => const SearchViewController());
        } else if (index == 2) {
          return CupertinoTabView(builder: (context) {
            return BlocProvider(
              create: (context) =>
                  FavouritesBloc(context.read<AuthenticationManager>())
                    ..add(LoadFavourites()),
              child: const FavouritesViewController(),
            );
          });
        } else if (index == 3) {
          return CupertinoTabView(
              builder: (context) => const ProfileViewController());
        } else {
          return CupertinoTabView(
            builder: (context) {
              return Center(
                child: Text("Index: $index"),
              );
            },
          );
        }
      },
    );
  }
}
