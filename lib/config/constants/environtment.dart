import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String theMovieDBKey = dotenv.env['THE_MOVIEDB_KEY'] ?? '';
}
