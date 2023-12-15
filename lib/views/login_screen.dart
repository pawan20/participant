import 'package:flutter/material.dart';
import 'package:participant/utils/constants.dart';
import 'package:participant/view_models/login_screen_view_model.dart';
import 'package:participant/views/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final viewModel = LoginScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: headerTextStyle,
                      ),
                      space12,
                      Text(
                        'Please sign in to continue',
                        style: bodyTextStyle,
                      ),
                      Text(
                        'Username: Mike12, Pass: Test1234!',
                        style: smallTextStyle,
                      ),
                    ],
                  ),
                ),
                space30,
                TextFormField(
                  controller: viewModel.usernameTextFieldController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    if (value.length < 5) {
                      return 'Username must be at least 5 characters long';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                  ),
                ),
                space12,
                TextFormField(
                  controller: viewModel.passwordTextFieldController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }

                    if (value.length <= 8) {
                      return 'Password must be at least 8 characters long';
                    }

                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }

                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return 'Password must contain at least one lowercase letter';
                    }

                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return 'Password must contain at least one digit';
                    }

                    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return 'Password must contain at least one special character';
                    }

                    return null;
                  },
                ),
                Consumer<LoginScreenViewModel>(
                  builder: (context, vm, child) {
                    if (viewModel.errorMessage != null) {
                      return Column(
                        children: [
                          space12,
                          Text(
                            vm.errorMessage!,
                            style: smallTextStyle.copyWith(
                              color: Colors.red[400],
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                space30,
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                    ),
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: bodyTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final isSuccess = viewModel.handelLoginCta();
                      if (isSuccess) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
