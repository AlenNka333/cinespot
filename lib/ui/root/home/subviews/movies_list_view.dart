import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinespot/core/extensions/double_extension.dart';
import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/root/home/home_view_model.dart';
import 'package:cinespot/ui/root/home/movie_details_view_controller.dart';
import 'package:cinespot/ui/root/home/movie_details_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating/flutter_rating.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (_, viewModel, __) {
        return ListView.separated(
          separatorBuilder: (_, __) => SizedBox(width: 10),
          controller: viewModel.scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(bottom: 5.0, left: 10),
          itemCount: viewModel.movies.length + 1,
          itemBuilder: (_, index) {
            if (index == viewModel.movies.length) {
              return CupertinoActivityIndicator();
            } else {
              final movie = viewModel.movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => MovieDetailsViewModel(
                            context.read<AuthenticationManager>(),
                            selectedMovie: movie),
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
