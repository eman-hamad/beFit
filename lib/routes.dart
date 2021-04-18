import 'package:befit_app/UI/Login.dart';
import 'package:befit_app/UI/Onboarding.dart';
import 'package:befit_app/UI/Splash.dart';
import 'package:befit_app/UI/home.dart';
import 'package:befit_app/UI/register.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  Register.routeName: (context) => Register(),
  OnboardingScreen.routeName: (context) => OnboardingScreen(),
  Login.routeName: (context) => Login(),
  Home.routeName: (context) => Home()
};
