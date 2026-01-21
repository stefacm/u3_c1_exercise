import 'package:flutter/material.dart';

class CustomRoutes {
  static Route fade(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route slide(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
