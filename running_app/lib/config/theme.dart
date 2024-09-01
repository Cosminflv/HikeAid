import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme lightColorScheme = const ColorScheme.light(
  surface: Colors.white,
  onSurface: Color.fromARGB(255, 0, 0, 0),
  surfaceContainerHighest: Color.fromARGB(255, 240, 248, 240),
  onSurfaceVariant: Color.fromARGB(255, 112, 128, 115),
  primary: Color(0xFF96BE8C), // Main green color
  inversePrimary: Color.fromARGB(255, 240, 255, 240),
  onPrimary: Color.fromARGB(255, 255, 255, 255),
  primaryContainer: Color.fromARGB(255, 213, 237, 209),
  onPrimaryContainer: Color.fromARGB(255, 28, 55, 34),
  secondary: Color.fromARGB(255, 119, 139, 118),
  onSecondary: Color.fromARGB(255, 255, 255, 255),
  secondaryContainer: Color.fromARGB(255, 224, 231, 220),
  onSecondaryContainer: Color.fromARGB(255, 35, 49, 39),
  surfaceContainerLowest: Color.fromARGB(255, 245, 252, 245),
  outline: Colors.black38,
  outlineVariant: Color.fromARGB(255, 215, 225, 215),
  shadow: Color.fromARGB(255, 180, 190, 180),
  surfaceTint: Color.fromARGB(255, 230, 240, 230),
  tertiary: Color.fromARGB(255, 86, 117, 85),
);

ColorScheme darkColorScheme = const ColorScheme.dark(
  surface: Color.fromARGB(255, 28, 30, 28),
  onSurface: Color.fromARGB(255, 240, 240, 240),
  surfaceContainerHighest: Color.fromARGB(255, 38, 48, 38),
  onSurfaceVariant: Color.fromARGB(255, 150, 160, 150),
  primary: Color(0xFF96BE8C), // Main green color
  inversePrimary: Color.fromARGB(255, 50, 75, 50),
  onPrimary: Color.fromARGB(255, 28, 55, 34),
  primaryContainer: Color.fromARGB(255, 75, 99, 74),
  onPrimaryContainer: Color.fromARGB(255, 220, 240, 220),
  secondary: Color.fromARGB(255, 100, 120, 100),
  onSecondary: Color.fromARGB(255, 220, 240, 220),
  secondaryContainer: Color.fromARGB(255, 60, 75, 60),
  onSecondaryContainer: Color.fromARGB(255, 215, 225, 215),
  surfaceContainerLowest: Color.fromARGB(255, 18, 20, 18),
  outline: Colors.white38,
  outlineVariant: Color.fromARGB(255, 75, 90, 75),
  shadow: Color.fromARGB(255, 0, 0, 0),
  surfaceTint: Color.fromARGB(255, 15, 25, 15),
  tertiary: Color.fromARGB(255, 70, 105, 70),
);

ThemeData lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  focusColor: Colors.black,
  iconTheme: IconThemeData(color: lightColorScheme.primary),
  hintColor: lightColorScheme.onSurfaceVariant.withOpacity(0.5),
  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: lightColorScheme.onPrimary)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: lightColorScheme.onPrimary, unselectedItemColor: lightColorScheme.onSurfaceVariant),
  textTheme: GoogleFonts.robotoCondensedTextTheme().copyWith(
    displayMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: lightColorScheme.onSurface),
    headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: lightColorScheme.onSurface),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: lightColorScheme.onSurface),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: lightColorScheme.onSurface),
    labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: lightColorScheme.onSurface),
    bodyMedium: TextStyle(fontSize: 16, color: lightColorScheme.onSurface),
    bodySmall: TextStyle(fontSize: 12, color: lightColorScheme.onSurfaceVariant),
  ),
  inputDecorationTheme: inputDecorationTheme(lightColorScheme),

  // extensions: [
  //   PullDownButtonTheme(
  //       routeTheme: PullDownMenuRouteTheme(backgroundColor: lightColorScheme.secondaryContainer),
  //       itemTheme: PullDownMenuItemTheme(
  //           textStyle: TextStyle(fontWeight: FontWeight.w300, color: lightColorScheme.onSurface))),
  // ],
);

ThemeData darkThemeData = ThemeData(
  colorScheme: darkColorScheme,
  iconTheme: IconThemeData(color: darkColorScheme.primary),
  hintColor: darkColorScheme.onSurfaceVariant.withOpacity(0.5),
  textTheme: GoogleFonts.robotoCondensedTextTheme().copyWith(
    displayMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: darkColorScheme.onSurface),
    headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkColorScheme.onSurface),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkColorScheme.onSurface),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkColorScheme.onSurface),
    labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: darkColorScheme.onSurface),
    bodyMedium: TextStyle(fontSize: 16, color: darkColorScheme.onSurface),
    bodySmall: TextStyle(fontSize: 12, color: darkColorScheme.onSurfaceVariant),
  ),
  inputDecorationTheme: inputDecorationTheme(darkColorScheme),
  // extensions: [
  //   PullDownButtonTheme(
  //       routeTheme: PullDownMenuRouteTheme(backgroundColor: darkColorScheme.secondaryContainer),
  //       dividerTheme: PullDownMenuDividerTheme(
  //           largeDividerColor: darkColorScheme.surfaceContainerHighest, dividerColor: darkColorScheme.onSurface),
  //       itemTheme: PullDownMenuItemTheme(
  //           textStyle: TextStyle(fontWeight: FontWeight.w300, color: darkColorScheme.onSurface))),
  // ],
);

// Used for all TextFields by default
InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) {
  const double width = 1.0;
  const BorderRadius radius = BorderRadius.all(Radius.circular(15.0));

  return InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(width: width, color: colorScheme.onSurface),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(width: width, color: colorScheme.onSurface),
    ),
  );
}
