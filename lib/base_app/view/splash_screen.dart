import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showSplash = false;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Flutter Starter")));
  }
}
