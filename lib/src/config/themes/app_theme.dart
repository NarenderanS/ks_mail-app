  import 'package:flutter/material.dart';

import '../../utils/constants/styles.dart';

ThemeData appThemeData() {
    return ThemeData(
          primarySwatch: Colors.lightBlue,
          // primaryColor: const Color.fromARGB(255, 248, 246, 246),
          // brightness: Brightness.light,
          dividerColor: Colors.black12,
          // colorScheme: (ColorScheme.light()),
          drawerTheme: drawerTheme,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.black54),
          inputDecorationTheme: InputDecorationTheme(
            // focusedBorder: OutlineInputBorder(
            //     borderSide: const BorderSide(color: Colors.lightBlueAccent),
            //     borderRadius: BorderRadius.circular(30)),
            // enabledBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.grey),
            // ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(30),
            ),
            prefixIconColor: MaterialStateColor.resolveWith(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.focused)) {
                  return states.contains(MaterialState.error)
                      ? Colors.red
                      : Colors.lightBlueAccent;
                }
                if (states.contains(MaterialState.error)) {
                  return Colors.red;
                }
                return Colors.black;
              },
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          dialogTheme: const DialogTheme(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              titleTextStyle: TextStyle(color: Colors.black),
              contentTextStyle: TextStyle(color: Colors.black)),
          floatingActionButtonTheme: floatingActionButtonTheme);
  }
