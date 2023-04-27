import 'package:flutter/material.dart';
import 'package:mama_resto/screens/home_screen.dart';
import 'package:mama_resto/theme_manager/color_manager.dart';
import 'package:mama_resto/theme_manager/font_manager.dart';
import 'package:mama_resto/theme_manager/navigation_manager.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';

import '../theme_manager/asset_manager.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        context.toJumpScreen(HomeScreen.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              80.0.spaceY,
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: const [
                    TextSpan(
                      text: 'Welcome to\n',
                      style: TextStyle(fontSize: 40),
                    ),
                    TextSpan(
                      text: '(MAri MAkan)\n',
                    ),
                    TextSpan(text: 'Resto')
                  ],
                  style: TextStyle(
                    color: ColorManager.black,
                    fontSize: 30,
                    fontFamily: FontManager.greatVibes,
                  ),
                ),
              ),
              30.0.spaceY,
              Image.asset(AssetManager.splash),
            ],
          ),
        ),
      ),
    );
  }
}
