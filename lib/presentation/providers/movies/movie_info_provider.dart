import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapProvider, Map<String, Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieMapProvider(getMovie: fetchMoreMovies);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapProvider extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapProvider({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state.containsKey(movieId)) return;

    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
