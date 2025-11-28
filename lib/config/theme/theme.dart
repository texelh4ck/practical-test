import 'package:flutter/material.dart';

final theme = ThemeData(
  colorScheme: _colorScheme,
  appBarTheme: _appbar,
  textTheme: _text,
  bottomAppBarTheme: _bottomNavigationBar,
  chipTheme: _chip,
  searchBarTheme: _searchBar,
);

final _appbar = AppBarTheme(centerTitle: true);

final _bottomNavigationBar = BottomAppBarTheme();

final _chip = ChipThemeData(
  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
  shape: StadiumBorder(),
);

final _colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.lightGreen,
  brightness: Brightness.dark,
);

// final _colorScheme = ColorScheme(
//   brightness: Brightness.dark,
//   primary: Colors.red,
//   onPrimary: Colors.red.shade50,
//   secondary: Colors.yellow,
//   onSecondary: Colors.yellow.shade50,
//   error: Colors.redAccent,
//   onError: Colors.redAccent.shade100,
//   surface: Colors.red.shade400.withAlpha(10),
//   onSurface: Colors.red.shade500,
// );

final _text = TextTheme(
  titleLarge: TextStyle(fontSize: 24),
  titleMedium: TextStyle(fontSize: 18),
  bodyMedium: TextStyle(color: _colorScheme.onSurfaceVariant),
  bodySmall: TextStyle(color: _colorScheme.onSurfaceVariant, fontSize: 10),
);

final _searchBar = SearchBarThemeData(
  elevation: WidgetStatePropertyAll(0),
  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20)),
  side: WidgetStatePropertyAll(
    BorderSide(
      color: _colorScheme.onSurfaceVariant,
      width: 1,
      style: BorderStyle.solid,
    ),
  ),
);
