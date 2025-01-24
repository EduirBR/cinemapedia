import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia/config/router/router_handlers.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> moviesRoutes = [
  addRoute(path: '/', name: HomeScreen.name, view: HomeScreen()),
];
