import 'package:flutter/material.dart';
import 'package:participant/services/locator.dart';
import 'package:participant/utils/app_providers.dart';
import 'package:participant/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await setupLocator();

  runApp(
    MultiProvider(
      providers: appProviders(), 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mural App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(91, 54, 247, 1),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
