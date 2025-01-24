import 'package:cinemapedia/presentation/movies_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static List<RouteBase> routes = [
    ...moviesRoutes,
  ];
  static GoRouter router = GoRouter(
    routes: routes,
    initialLocation: '/',
  );
}
