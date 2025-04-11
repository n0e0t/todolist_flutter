import 'package:flutter/material.dart';

void fadeToPage(BuildContext context, Widget page,int duration) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, anim, __, child) => FadeTransition(
        opacity: anim,
        child: child,
      ),
      transitionDuration: Duration(milliseconds: duration),
    ),
  );
}
