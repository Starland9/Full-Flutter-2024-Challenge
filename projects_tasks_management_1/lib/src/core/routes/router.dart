import 'package:auto_route/auto_route.dart';
import 'package:projects_tasks_management_1/src/screens/home/home_screen.dart';
import 'package:projects_tasks_management_1/src/screens/projects/projects_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(
          page: ProjectsRoute.page,
          initial: true,
        ),
      ];
}
