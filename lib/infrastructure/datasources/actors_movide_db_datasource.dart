import 'package:cinemapedia/config/constants/environtment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/infrastructure/mappers/actors_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorsMovideDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: Env.baseUrl,
      queryParameters: {'api_key': Env.theMovieDBKey, 'language': 'es-MX'}));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final actorsResonse = CreditsResponse.fromJson(response.data);

    final casts = actorsResonse.cast
        .map((cast) => ActorsMapper.castDBToEntity(cast))
        .toList();
    return casts;
  }
}
