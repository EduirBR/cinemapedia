import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                color: color.primary,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Cinemapedia',
                style: titleStyle,
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    final movieRepository = ref.read(movieRepositoryProvider);
                    showSearch(
                        context: context,
                        delegate: SearchMovieDelegate(
                            searchMovies: movieRepository.searchMovies));
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
        ),
      ),
    );
  }
}
