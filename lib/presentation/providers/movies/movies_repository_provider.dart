import 'package:cinemapedia/infrastructure/datasources/the_movie_db_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//este repositorio es inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImplementation(dataSource: TheMovieDbDatasource());
});
