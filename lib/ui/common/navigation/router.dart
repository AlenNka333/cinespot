import 'package:cinespot/ui/common/tab_bar/tab_bar_view.dart';
import 'package:cinespot/ui/root/login/login_view_controller.dart';
import 'package:cinespot/ui/root/splash/splash_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AppRouter {
  static const String splashPage = '/';
  static const String homePage = '/home';
  static const String loginPage = '/login';
  static const String profilePage = '/profile';

  AppRouter._();

  static void launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return CupertinoPageRoute(builder: (_) => const SplashViewController());
      case homePage:
        return CupertinoPageRoute(builder: (_) => const CupertinoTabBarApp());
      case loginPage:
        return CupertinoPageRoute(
          builder: (_) => LoginViewController(),
        );
      default:
        throw FormatException("Route not found");
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
