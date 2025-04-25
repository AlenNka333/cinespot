import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:cinespot/ui/root/profile/bloc/profile_bloc.dart';
import 'package:cinespot/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewController extends StatelessWidget {
  const ProfileViewController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(context.read<AuthenticationManager>()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.of(context, rootNavigator: true)
                .pushReplacementNamed(AppRouter.loginPage);
          }
        },
        builder: (context, state) {
          final bloc = context.read<ProfileBloc>();

          return CupertinoPageScaffold(
            backgroundColor: AppStyle.appTheme.scaffoldBackgroundColor,
            child: SafeArea(
              child: Center(
                child: TextButton(
                  onPressed: () => bloc.add(LogoutButtonPressed()),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(88, 112, 138, 1),
                  ),
                  child: const Text("Logout"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
