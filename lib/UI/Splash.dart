import 'dart:async';

import 'package:befit_app/UI/Onboarding.dart';
import 'package:befit_app/size_config.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static String routeName = "/Splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
 
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "asset/backimage.png",
                ),
                fit: BoxFit.fill),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: getProportionateScreenWidth(context, 0.50),
                height: getProportionateScreenHeight(context, 0.25),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("asset/fitness.png"),
                        fit: BoxFit.fill)),
              ),
              Text(
                "Be Fit",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    ));
  }
}
