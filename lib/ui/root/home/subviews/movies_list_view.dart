import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinespot/ui/root/home/bloc/home_bloc.dart';
import 'package:cinespot/ui/root/home/movie_details/bloc/movie_details_bloc.dart';
import 'package:cinespot/utils/extensions/double_extension.dart';
import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/root/home/movie_details/movie_details_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';

class MoviesListView extends StatefulWidget {
  const MoviesListView({super.key});

  @override
  State<MoviesListView> createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeBloc>().add(LoadMoreMovies());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<Movie>>(
      selector: (state) => state.movies,
      builder: (context, movies) {
        final hasNextPage =
            context.select((HomeBloc bloc) => bloc.state.hasNextPage);

        return ListView.separated(
          separatorBuilder: (_, __) => SizedBox(width: 10),
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(bottom: 5.0, left: 10),
          itemCount: hasNextPage ? movies.length + 1 : movies.length,
          itemBuilder: (_, index) {
            if (index == movies.length) {
              return CupertinoActivityIndicator();
            } else {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => MovieDetailsBloc(
                            context.read<AuthenticationManager>(), movie)
                          ..add(LoadInitialMovieData()),
                        child: const MovieDetailsViewController(),
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 150,
                  child: MoviesListItemView(
                    movie: movie,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class MoviesListItemView extends StatelessWidget {
  final Movie movie;

  const MoviesListItemView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 5.0,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              movie.posterUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        AutoSizeText(
          movie.title.toString(),
          style: TextStyle(fontWeight: FontWeight.w400),
          maxLines: 2,
          textAlign: TextAlign.center,
          minFontSize: 10,
          maxFontSize: 15,
        ),
        FittedBox(
          fit: BoxFit.fitHeight,
          child: StarRating(
            rating: movie.voteAverage.halfRating(),
            allowHalfRating: true,
            color: Colors.amber,
            borderColor: Color.fromRGBO(87, 111, 130, 1),
          ),
        )
      ],
    );
  }
}
