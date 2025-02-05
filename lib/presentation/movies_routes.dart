import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia/config/router/router_handlers.dart';
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> moviesRoutes = [
  addRoute(path: '/', name: HomeScreen.name, view: HomeScreen(), childRoutes: [
    addRoute(
      path: 'movie/:id',
      name: MovieScreen.name,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? '';
        return customTransitionBuild(MovieScreen(movieId: movieId));
      },
    ),
  ]),
];
