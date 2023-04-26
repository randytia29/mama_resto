import 'package:flutter/material.dart';

extension Navigate on BuildContext {
  void toScreen(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  void toJumpScreen(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);

  void toLoginScreen(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false,
          arguments: arguments);

  void toBackScreen() => Navigator.of(this).pop();
}
