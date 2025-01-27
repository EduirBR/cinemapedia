import 'package:cinemapedia/config/constants/environtment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_db_response.dart';
import 'package:dio/dio.dart';

class TheMovieDbDatasource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: Env.baseUrl,
      queryParameters: {'api_key': Env.theMovieDBKey, 'language': 'es-MX'}));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final movieDbResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDbResponse.results
        .where((movie) => (movie.posterPath != ''))
        .map((movie) => MovieMapper.movieDBToEntity(movie))
        .toList();
    return movies;
  }
}
