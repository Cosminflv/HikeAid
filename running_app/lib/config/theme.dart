import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme lightColorScheme = const ColorScheme.light(
  surface: Colors.white,
  onSurface: Color.fromARGB(255, 0, 0, 0),
  surfaceContainerHighest: Color.fromARGB(255, 239, 239, 239),
  onSurfaceVariant: Color.fromARGB(255, 139, 138, 143),
  primary: Color.fromARGB(255, 21, 29, 85),
  inversePrimary: Color.fromARGB(255, 0, 0, 0),
  onPrimary: Color.fromARGB(255, 255, 255, 255),
  primaryContainer: Color.fromARGB(255, 223, 224, 255),
  onPrimaryContainer: Color.fromARGB(255, 0, 0, 0),
  secondary: Color.fromARGB(255, 85, 85, 85),
  onSecondary: Color.fromARGB(255, 255, 255, 255),
  secondaryContainer: Color.fromARGB(255, 242, 242, 242),
  onSecondaryContainer: Color.fromARGB(255, 255, 255, 255),
  surfaceContainerLowest: Color.fromARGB(255, 243, 242, 248),
  outline: Colors.black38,
  outlineVariant: Color.fromARGB(255, 231, 231, 233),
  shadow: Color.fromARGB(255, 150, 150, 150),
  surfaceTint: Color.fromARGB(255, 243, 243, 243),
  tertiary: Color.fromARGB(255, 59, 65, 108),
);

ColorScheme darkColorScheme = const ColorScheme.dark(
  surface: Color.fromARGB(255, 33, 33, 33),
  onSurface: Color.fromARGB(255, 255, 255, 255),
  surfaceContainerHighest: Color.fromARGB(255, 48, 48, 48),
  onSurfaceVariant: Color.fromARGB(255, 201, 201, 201),
  primary: Color.fromARGB(255, 58, 75, 185),
  inversePrimary: Color.fromARGB(255, 255, 255, 255),
  onPrimary: Color.fromARGB(255, 255, 255, 255),
  primaryContainer: Color.fromARGB(255, 121, 134, 203),
  onPrimaryContainer: Color.fromARGB(255, 0, 0, 0),
  secondary: Color.fromARGB(255, 169, 169, 169),
  onSecondary: Color.fromARGB(255, 0, 0, 0),
  secondaryContainer: Color.fromARGB(255, 66, 66, 66),
  onSecondaryContainer: Color.fromARGB(255, 255, 255, 255),
  surfaceContainerLowest: Color.fromARGB(255, 28, 28, 30),
  outline: Colors.white38,
  outlineVariant: Color.fromARGB(255, 58, 58, 60),
  shadow: Color.fromARGB(255, 0, 0, 0),
  surfaceTint: Color.fromARGB(255, 18, 18, 18),
  tertiary: Color.fromARGB(255, 64, 71, 130),
);

// ColorScheme darkColorScheme = const ColorScheme.dark(
//   surface: Color.fromARGB(255, 0, 0, 0),
//   onSurface: Color.fromARGB(255, 255, 255, 255),
//   surfaceContainerHighest: Color.fromARGB(255, 30, 30, 30),
//   onSurfaceVariant: Color.fromARGB(255, 145, 145, 153),
//   primary: Color.fromARGB(255, 135, 145, 255),
//   inversePrimary: Color.fromARGB(255, 255, 255, 255),
//   onPrimary: Color.fromARGB(255, 0, 0, 0),
//   primaryContainer: Color.fromARGB(255, 227, 202, 254),
//   onPrimaryContainer: Color.fromARGB(255, 255, 255, 255),
//   secondary: Color.fromARGB(255, 77, 77, 77),
//   onSecondary: Color.fromARGB(255, 0, 0, 0),
//   secondaryContainer: Color.fromARGB(255, 45, 45, 46),
//   onSecondaryContainer: Color.fromARGB(255, 0, 0, 0),
//   surfaceContainerLowest: Color.fromARGB(255, 0, 0, 0),
//   outline: Colors.white38,
//   outlineVariant: Color.fromARGB(255, 54, 54, 57),
// );

CupertinoThemeData getCupertinoTheme() {
  return const CupertinoThemeData(
    primaryContrastingColor: Color.fromARGB(255, 228, 227, 234),
    primaryColor: Colors.blueAccent,
    barBackgroundColor: Colors.white,
    textTheme: CupertinoTextThemeData(),
  );
}

// This color is used for button background(such as transport mode buttons for location details panel)
const Color highlightColor = Color.fromARGB(255, 242, 242, 242);

// This color is used for go button background
const Color goColor = Color.fromARGB(255, 93, 201, 82);

// This color is used for end button background
const Color errorColor = Color.fromARGB(255, 238, 56, 49);

// This color is used for warning button background
const Color warningColor = Color.fromARGB(255, 242, 149, 0);

// This color is used for favorites button
const Color favoritesColor = Color.fromARGB(255, 255, 204, 0);

// This color is used for content inside buttons with background color not from the theme
const Color buttonContentColor = Color.fromARGB(255, 255, 255, 255);

// This color is used for transparent items
const Color transparentColor = Colors.transparent;

Color getThemedItemBackgroundColor(BuildContext context) {
  return (Theme.of(context).brightness == Brightness.light)
      ? Theme.of(context).colorScheme.surface
      : Theme.of(context).colorScheme.surfaceContainerHighest;
}

Color getContainerColor(BuildContext context) {
  return (Theme.of(context).brightness == Brightness.light)
      ? Theme.of(context).colorScheme.surface
      : Theme.of(context).colorScheme.surfaceContainerHighest;
}

Color getAppbarColor(BuildContext context) {
  return (Theme.of(context).brightness == Brightness.light)
      ? Theme.of(context).colorScheme.surface
      : Theme.of(context).colorScheme.surfaceTint;
}

Color getBackgroundColor(BuildContext context) {
  return (Theme.of(context).brightness == Brightness.light)
      ? Theme.of(context).colorScheme.surfaceTint
      : Theme.of(context).colorScheme.surface;
}

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
