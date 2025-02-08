import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_by_movies_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _CustomSliversAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyles.titleLarge,
                    ),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),

        //Generos de la pelicula
        Padding(
          padding: EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((e) => Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(e),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  )))
            ],
          ),
        ),

        _ActorsByMovie(movieID: movie.id),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final int movieID;
  const _ActorsByMovie({required this.movieID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (!actorsByMovie.containsKey(movieID.toString())) {
      return CircularProgressIndicator(strokeWidth: 2);
    }
    final actors = actorsByMovie[movieID.toString()]!;
    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final actor = actors[index];
            return Container(
              padding: EdgeInsets.all(8),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(actor.name, maxLines: 2),
                  Text(
                    actor.character ?? '',
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class _CustomSliversAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliversAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(children: [
          SizedBox.expand(
              child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const SizedBox();
              }
              return FadeIn(child: child);
            },
          )),
          // Background gradient
          SizedBox.expand(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                  0.7,
                  1
                ],
                        colors: [
                  Colors.transparent,
                  Colors.black87,
                ]))),
          ),
          //Header Gradient
          SizedBox.expand(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topLeft, stops: [
              0,
              0.2
            ], colors: [
              Colors.black87,
              Colors.transparent,
            ]))),
          ),
        ]),
        titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
