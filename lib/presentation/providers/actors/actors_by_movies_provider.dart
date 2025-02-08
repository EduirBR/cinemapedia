import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/presentation/providers/actors/actor_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMoviesNotifier, Map<String, List<Actor>>>(
        (ref) {
  final fetchActorsFromMovie =
      ref.watch(actorsRepositoryProvider).getActorsByMovie;
  return ActorsByMoviesNotifier(getActors: fetchActorsFromMovie);
});

typedef GetMovieCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMoviesNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetMovieCallback getActors;

  ActorsByMoviesNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state.containsKey(movieId)) return;

    final actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
