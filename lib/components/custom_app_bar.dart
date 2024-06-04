import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.actions = const <Widget>[],
    this.leading,
    this.title,
    this.titleTextStyle,
  });

  final List<Widget> actions;
  final Widget? leading;
  final Widget? title;
  final TextStyle? titleTextStyle;

  @override
  Size get preferredSize => const Size.fromHeight(55.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14, top: 10),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: title,
        titleTextStyle:
            titleTextStyle ?? Theme.of(context).textTheme.headlineMedium,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: actions
            .map((action) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: action,
                ))
            .toList(),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: leading,
        ),
        leadingWidth: 70,
      ),
    );
  }
}

