import 'package:cinespot/ui/root/login/bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    final state = context.watch<LoginBloc>().state;
    final isLoading = state is LoginLoading;

    return Padding(
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
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
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
                _loginTextField(
                  placeholder: "Username",
                  controller: _usernameController,
                ),
                const SizedBox(height: 10),
                _loginTextField(
                    controller: _passwordController,
                    placeholder: "Password",
                    obscureText: !bloc.isPasswordVisible,
                    suffix: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => bloc.add(TogglePasswordVisibility()),
                      child: Icon(
                        color: CupertinoColors.white,
                        bloc.isPasswordVisible
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash,
                      ),
                    )),
                const SizedBox(height: 20),
                isLoading
                    ? const CupertinoActivityIndicator()
                    : TextButton(
                        onPressed: () {
                          bloc.add(LoginButtonPressed(
                              username: _usernameController.text,
                              password: _passwordController.text));
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromRGBO(88, 112, 138, 1),
                        ),
                        child: const Text("Login"),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginTextField({
    required String placeholder,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffix,
  }) {
    return CupertinoTextField(
      placeholder: placeholder,
      controller: controller,
      obscureText: obscureText,
      padding: const EdgeInsets.all(16),
      style: const TextStyle(color: CupertinoColors.white),
      placeholderStyle:
          const TextStyle(color: Color.fromARGB(255, 196, 195, 220)),
      decoration: const BoxDecoration(
        color: CupertinoColors.transparent,
        border: Border(
          bottom: BorderSide(color: CupertinoColors.black, width: 1.0),
        ),
      ),
      suffix: suffix,
    );
  }
}
