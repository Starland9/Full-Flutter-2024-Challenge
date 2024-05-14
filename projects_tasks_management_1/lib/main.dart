import 'package:flutter/material.dart';
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
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: lightTheme(),
    );
  }
}

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: Colors.blue,
    ),
    scaffoldBackgroundColor: ColorName.scaffoldBackground,
    useMaterial3: true,
  );
}
