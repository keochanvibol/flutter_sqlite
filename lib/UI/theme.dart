import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color blusihClr = Color(0xFF4e5ae8);
const primaryClr = blusihClr;
const darkGreyClr = Color(0xFF121212);

class Themes {
  static final light =
      ThemeData(primaryColor: primaryClr, brightness: Brightness.light);
  static final dark =
      ThemeData(primaryColor: darkGreyClr, brightness: Brightness.dark);
}
