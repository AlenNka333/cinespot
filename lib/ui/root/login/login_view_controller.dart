import 'package:cinespot/core/app_style.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:cinespot/ui/root/login/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewController extends StatelessWidget {
  const LoginViewController({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (viewModel.isAuthorized) {
            Navigator.of(context).pushReplacementNamed(AppRouter.homePage);
          }
        });

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: Column(
                          children: [
                            const Text(
                              "Welcome to Cinespot!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 20),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: Column(
                          children: [
                            textField(
                                controller: viewModel.usernameController,
                                placeholder: "Username"),
                            const SizedBox(height: 10),
                            textField(
                                controller: viewModel.passwordController,
                                placeholder: "Password",
                                obscureText: !viewModel.isPasswordVisible,
                                suffix: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    context
                                        .read<LoginViewModel>()
                                        .togglePasswordVisibility();
                                  },
                                  child: Icon(
                                    color: CupertinoColors.white,
                                    viewModel.isPasswordVisible
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash,
                                  ),
                                )),
                            const SizedBox(height: 20),
                            Selector<LoginViewModel, bool>(
                              selector: (_, viewModel) => viewModel.isLoading,
                              builder: (_, isLoading, __) {
                                if (isLoading) {
                                  return CupertinoActivityIndicator();
                                } else {
                                  return TextButton(
                                    onPressed: () {
                                      viewModel.login();
                                    },
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          const Color.fromRGBO(88, 112, 138, 1),
                                    ),
                                    child: const Text("Login"),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget textField(
      {required TextEditingController controller,
      required String placeholder,
      bool obscureText = false,
      Widget? suffix}) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      obscureText: obscureText,
      padding: const EdgeInsets.all(16),
      style: const TextStyle(color: CupertinoColors.white),
      placeholderStyle:
          const TextStyle(color: Color.fromARGB(255, 196, 195, 220)),
      decoration: const BoxDecoration(
        color: CupertinoColors.transparent,
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.black,
            width: 1.0,
          ),
        ),
      ),
      suffix: suffix,
    );
  }
}
