import 'package:flutter/material.dart';
import '../interfaces/navigation_service.dart';
import '../../routes/custom_routes.dart';

class NavigationService implements INavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get _context => navigatorKey.currentContext!;

  @override
  void navigateTo(Widget screen) {
    Navigator.push(_context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  void navigateToWithFade(Widget screen) {
    Navigator.push(_context, CustomRoutes.fade(screen));
  }

  @override
  void navigateToWithSlide(Widget screen) {
    Navigator.push(_context, CustomRoutes.slide(screen));
  }

  @override
  void navigateBack() {
    Navigator.pop(_context);
  }

  @override
  void navigateAndReplace(Widget screen) {
    Navigator.pushReplacement(_context, CustomRoutes.fade(screen));
  }
}