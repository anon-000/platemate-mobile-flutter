import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppColors {
  static const brightBackground = Color(0xff0A061D);
  static const darkBackground = Color(0xff3e3e3e);
  static const borderColor = Color(0xffBABABA);
  static const brightSecondaryColor = Color(0xff3E9AFF);
  static const green = Color(0xff56AB18);
  static const divider = Color(0xffF1F1F1);
  static const darkGrey = Color(0xff676F75);
  static const grey = Color(0xff888888);
  static const brightTextColor = Color(0xff2D2D2D);
  static const dividerSlot = Color(0xffEAEAEA);
  static const blue = Color(0xff3582EC);
  static const desc = Color(0xffB1B1B1);
  static const primary = Color(0xffB1B1B1);
  static const labelColor = Color(0xff949494);

  static const MaterialColor brightPrimary =
      MaterialColor(brightPrimaryValue, <int, Color>{
    50: Color(0xFFE2E7EC),
    100: Color(0xFFB7C2D1),
    200: Color(0xFF8799B2),
    300: Color(0xFF577093),
    400: Color(0xFF33527B),
    500: Color(brightPrimaryValue),
    600: Color(0xFF0D2E5C),
    700: Color(0xFF0B2752),
    800: Color(0xFF082048),
    900: Color(0xFF041436),
  });
  static const int brightPrimaryValue = 0xFF0F3364;

  static const MaterialColor darkPrimary =
      MaterialColor(_darkprimaryPrimaryValue, <int, Color>{
    50: Color(0xFFFFE1E9),
    100: Color(0xFFFFB5C7),
    200: Color(0xFFFF84A2),
    300: Color(0xFFFF527C),
    400: Color(0xFFFF2D60),
    500: Color(_darkprimaryPrimaryValue),
    600: Color(0xFFFF073E),
    700: Color(0xFFFF0635),
    800: Color(0xFFFF042D),
    900: Color(0xFFFF021F),
  });
  static const int _darkprimaryPrimaryValue = 0xFFFF0844;

  static const MaterialColor darkprimaryAccent =
      MaterialColor(_darkprimaryAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_darkprimaryAccentValue),
    400: Color(0xFFFFBFC4),
    700: Color(0xFFFFA6AC),
  });
  static const int _darkprimaryAccentValue = 0xFFFFF2F3;
}
