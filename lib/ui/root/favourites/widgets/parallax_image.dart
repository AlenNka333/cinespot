import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:cinespot/ui/common/subviews/cinespot_button_view.dart';
import 'package:cinespot/ui/root/favourites/subviews/movie_cell/bloc/favourite_movie_cell_bloc.dart';
import 'package:share/share.dart';

class ParallaxImage extends StatelessWidget {
  final Movie movie;
  final double horizontalSlide;

  const ParallaxImage({
    super.key,
    required this.movie,
    required this.horizontalSlide,
  });

  @override
  Widget build(BuildContext context) {
    final scale = 1 - horizontalSlide.abs();
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        SizedBox(
          width: size.width * ((scale * 0.8) + 0.8),
          height: size.height * ((scale * 0.3) + 0.3),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.network(
              movie.posterUrl,
              alignment: Alignment(horizontalSlide, 1),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Flexible(child: _detailsView(context, movie)),
      ],
    );
  }

  Widget _detailsView(BuildContext context, Movie movie) {
    return BlocBuilder<FavouriteMovieCellBloc, FavouriteMovieCellState>(
      builder: (context, state) {
        final bloc = context.read<FavouriteMovieCellBloc>();
        final trailerUrl =
            state is FavouriteMovieCellLoaded ? state.trailerUrl : "";

        return ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                CinespotButtonView(
                    title: "Trailer",
                    enabled: trailerUrl.isNotEmpty,
                    onTab: () {
                      if (trailerUrl.isNotEmpty) {
                        AppRouter.launchURL(trailerUrl);
                      }
                    }),
                CinespotButtonView(
                    title: "Recommend",
                    enabled: trailerUrl.isNotEmpty,
                    onTab: () {
                      if (trailerUrl.isNotEmpty) {
                        Share.share(trailerUrl);
                      }
                    }),
                IconButton(
                  onPressed: () {
                    bloc.add(RemoveMovieFromFavourites());
                  },
                  icon: Icon(CupertinoIcons.heart),
                  isSelected: bloc.isMovieFavourite,
                  selectedIcon: Icon(CupertinoIcons.heart_fill),
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              movie.overview,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        );
      },
    );
  }
}
