import 'package:cinemapedia/presentation/providers/movies/initial_loading_provier.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slide_show_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_horizontal_list_view.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_botton_navigation_bar.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottonNavigationBar(),
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoadingProvider = ref.watch(initialProvider);
    if (initialLoadingProvider) return FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(movieSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(slivers: [
      //este aparece y desaparece cuando se hace scroll
      SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(),
        title: CustomAppBar(),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            // CustomAppBar(),
            MoviesSlideShow(movies: slideShowMovies),
            MoviesHorizontalListView(
              movies: nowPlayingMovies,
              title: 'En cines',
              subTitle: 'Ahora',
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),

            MoviesHorizontalListView(
              movies: popularMovies,
              title: 'Populares',
              loadNextPage: () {
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListView(
              movies: topRatedMovies,
              title: 'Mejor Calificadas',
              loadNextPage: () {
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListView(
              movies: upcomingMovies,
              title: 'Proximamente',
              subTitle: 'En este mes',
              loadNextPage: () {
                ref.read(upcomingMoviesProvider.notifier).loadNextPage();
              },
            ),
          ],
        );
      }, childCount: 1))
    ]);
  }
}
