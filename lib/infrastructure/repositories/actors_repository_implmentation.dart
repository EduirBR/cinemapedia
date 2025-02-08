import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/domain/repositories/actors_repositories.dart';

class ActorsRepositoryImplmentation extends ActorsRepository {
  final ActorsDatasource dataSource;

  ActorsRepositoryImplmentation({required this.dataSource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return dataSource.getActorsByMovie(movieId);
  }
}
