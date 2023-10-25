import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Ui/Home/HomeScrean.dart';

import '../../Provider/AppConfigProvider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  static const String routeName = "Splash";

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), navigateTo);
  }

  void navigateTo() {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScrean.routeName, (route) => false);
  }

  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Image.asset(
        provider.appTheme == ThemeMode.light
            ? 'assets/splash.png'
            : 'assets/splash – 1.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
