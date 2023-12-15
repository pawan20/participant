import 'package:flutter/material.dart';
import 'package:participant/utils/constants.dart';
import 'package:participant/view_models/splash_screen_view_model.dart';
import 'package:participant/views/home_screen.dart';
import 'package:participant/views/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final viewModel = SplashScreenViewModel();

  @override
  void initState() {
    viewModel.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Consumer<SplashScreenViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return Container(
                color: Theme.of(context).colorScheme.primary,
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Mural Demo App',
                        style: headerTextStyle.copyWith(color: Colors.white),
                      ),
                      Text('Developer: Pawandeep Singh', style:smallTextStyle.copyWith(color: Colors.white) ,)
                    ],
                  ),
                ),
              );
            } else {
              return viewModel.isUserLoggedIn ? const HomeScreen() : LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
