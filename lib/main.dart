import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/providers/auth_provider.dart';
import 'package:cinespot/data/sources/secure_storage_service.dart';
import 'package:cinespot/data/sources/shared_prefs_service.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:cinespot/ui/root/splash/cubit/splash_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  final apiClient = APIClient();
  final secureStorageService = SecureStorageService();
  final sharedPrefsService = SharedPrefsService();
  final authProvider = AuthProvider(
      apiClient: apiClient,
      secureStorageService: secureStorageService,
      sharedPrefsService: sharedPrefsService);
  final authManager = AuthenticationManager(authProvider: authProvider);

  runApp(
    MultiProvider(
      providers: [
        Provider<APIClient>(create: (_) => apiClient),
        Provider<AuthProvider>(create: (_) => authProvider),
        ChangeNotifierProvider<AuthenticationManager>(
            create: (_) => authManager),
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(
            context.read<AuthenticationManager>(),
          )..checkAuthorization(),
        ),
      ],
      child: CupertinoApp(
          initialRoute: AppRouter.splashPage,
          onGenerateRoute: AppRouter.generateRoute),
    ),
  );
}
