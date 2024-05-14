import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:calculatrice/src/screens/calc/calc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return AdaptiveTheme(
            builder: (light, dark) {
              return MaterialApp(
                title: 'Landry Calc',
                debugShowCheckedModeBanner: false,
                theme: light,
                darkTheme: dark,
                home: child,
              );
            },
            light: ligthTheme,
            dark: darkTheme,
            initial: savedThemeMode ?? AdaptiveThemeMode.system,
          );
        },
        child: const CalcScreen());
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
