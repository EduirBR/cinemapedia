import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasources/actors_movide_db_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actors_repository_implmentation.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImplmentation(dataSource: ActorsMovideDbDatasource());
});
