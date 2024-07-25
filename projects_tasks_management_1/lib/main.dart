import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_tasks_management_1/gen/colors.gen.dart';
import 'package:projects_tasks_management_1/src/core/constants/strings.dart';
import 'package:projects_tasks_management_1/src/core/routes/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 786),
      splitScreenMode: true,
      builder: (context, child) {
        return child!;
      },
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: lightTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorName.black,
      primary: Colors.black,
      primaryContainer: ColorName.avatarBackground,
      surface: ColorName.white,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: ColorName.scaffoldBackground,
    useMaterial3: true,
    textTheme: GoogleFonts.aBeeZeeTextTheme()
      ..apply(
        bodyColor: ColorName.black,
        displayColor: ColorName.black,
      ),
  );
}
