import 'package:cinespot/core/app_style.dart';
import 'package:cinespot/ui/root/profile/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileViewController extends StatelessWidget {
  const ProfileViewController({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, _) {
        return CupertinoPageScaffold(
          backgroundColor: AppStyle.appTheme.scaffoldBackgroundColor,
          child: SafeArea(
            child: Center(
              child: TextButton(
                onPressed: () => viewModel.logout(context),
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
    );
  }
}
