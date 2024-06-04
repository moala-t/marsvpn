import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: child,
    );
  }
}
