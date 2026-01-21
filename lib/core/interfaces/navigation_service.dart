import 'package:flutter/material.dart';

abstract class INavigationService {
  void navigateTo(Widget screen);
  void navigateToWithFade(Widget screen);
  void navigateToWithSlide(Widget screen);
  void navigateBack();
  void navigateAndReplace(Widget screen);
}