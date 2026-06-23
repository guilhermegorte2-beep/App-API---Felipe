import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Catálogo de Filmes',

      theme: ThemeData(

        brightness: Brightness.dark,

        scaffoldBackgroundColor:
            const Color(0xFF121212),

        primaryColor:
            const Color(0xFF800020),

        colorScheme: const ColorScheme.dark(

          primary: Color(0xFF800020),

          secondary: Color(0xFFB03060),
        ),

        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),

        appBarTheme: const AppBarTheme(

          backgroundColor: Color(0xFF1E1E1E),

          foregroundColor: Colors.white,

          elevation: 0,

          centerTitle: true,
        ),

        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFF1A1A1A),
        ),

        inputDecorationTheme:
            InputDecorationTheme(

          filled: true,

          fillColor: const Color(0xFF1E1E1E),

          hintStyle: const TextStyle(
            color: Colors.white54,
          ),

          labelStyle: const TextStyle(
            color: Colors.white70,
          ),

          floatingLabelStyle: const TextStyle(
            color: Color(0xFFB03060),
          ),

          prefixIconColor: Colors.white70,

          border: OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(15),

            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(15),

            borderSide: const BorderSide(
              color: Color(0xFF800020),
            ),
          ),

          focusedBorder: OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(15),

            borderSide: const BorderSide(
              color: Color(0xFFB03060),
              width: 2,
            ),
          ),
        ),

        elevatedButtonTheme:
            ElevatedButtonThemeData(

          style: ElevatedButton.styleFrom(

            backgroundColor:
                const Color(0xFF800020),

            foregroundColor: Colors.white,

            shape: RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(15),
            ),

            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),

            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        cardTheme: CardThemeData(

          color: const Color(0xFF1E1E1E),

          elevation: 4,

          shape: RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(15),
          ),
        ),

        snackBarTheme: SnackBarThemeData(

          backgroundColor:
              const Color(0xFF800020),

          contentTextStyle: const TextStyle(
            color: Colors.white,
          ),

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),

          behavior: SnackBarBehavior.floating,
        ),

        listTileTheme: const ListTileThemeData(

          iconColor: Colors.white,

          textColor: Colors.white,
        ),
      ),

      home: const LoginPage(),
    );
  }
}