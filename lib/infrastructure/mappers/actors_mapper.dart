import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorsMapper {
  static Actor castDBToEntity(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      character: cast.character,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
    );
  }
}
