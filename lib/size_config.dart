import 'package:flutter/material.dart';

// Get the proportionate height as per screen size
double getProportionateScreenHeight(BuildContext context, double inputHeight) {
  return (inputHeight) * MediaQuery.of(context).size.height;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(BuildContext context, double inputWidth) {
  return (inputWidth) * MediaQuery.of(context).size.width;
}
