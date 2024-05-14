import 'package:calculatrice/src/blocs/theme/theme_bloc.dart';
import 'package:calculatrice/src/screens/calc/calc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_theme/animated_theme_app.dart';
import 'package:flutter_animated_theme/animation_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final isDark = context.watch<ThemeBloc>().isDark;
          return AnimatedThemeApp(
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            animationDuration: const Duration(milliseconds: 500),
            animationType: AnimationType.CIRCULAR_ANIMATED_THEME,
            title: 'Landry Calc',
            debugShowCheckedModeBanner: false,
            theme: ligthTheme,
            darkTheme: darkTheme,
            home: const CalcScreen(),
          );
        },
      ),
    );
  }
}

ThemeData ligthTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.grey.shade100,
  textTheme: GoogleFonts.poppinsTextTheme(),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Colors.blue,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 29, 29, 29),
  textTheme: GoogleFonts.poppinsTextTheme(),
);
