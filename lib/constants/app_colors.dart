import 'package:flutter/material.dart';

const primarySwatch = Color(0xffEFC40B);

final MaterialColor primarySwatchMaterialColor = MaterialColor(
  primarySwatch.value, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  <int, Color>{
    50: Color(primarySwatch.withOpacity(0.1).value),//10%
    100: Color(primarySwatch.withOpacity(0.2).value),//20%
    200: Color(primarySwatch.withOpacity(0.3).value),//30%
    300: Color(primarySwatch.withOpacity(0.4).value),//40%
    400: Color(primarySwatch.withOpacity(0.5).value),//50%
    500: Color(primarySwatch.withOpacity(0.6).value),//60%
    600: Color(primarySwatch.withOpacity(0.7).value),//70%
    700: Color(primarySwatch.withOpacity(0.8).value),//80%
    800: Color(primarySwatch.withOpacity(0.9).value),//90%
    900: Color(primarySwatch.withOpacity(1.0).value),//100%
  },
);









