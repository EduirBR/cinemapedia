import 'package:cinemapedia/apps/movies/routes.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieRepositoryImplementation extends MoviesRepository {
  final MoviesDataSource dataSource;

  MovieRepositoryImplementation({required this.dataSource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }
}
