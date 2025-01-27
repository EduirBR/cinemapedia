import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String theMovieDBKey = dotenv.env['THE_MOVIEDB_KEY'] ?? '';
  static String baseUrl = dotenv.env['BASE_URL'] ?? '';
  static String notFoundIMGPath =
      'https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png';
}
