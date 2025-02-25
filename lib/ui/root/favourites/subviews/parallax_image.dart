import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:cinespot/ui/common/subviews/cinespot_button_view.dart';
import 'package:cinespot/ui/root/favourites/subviews/favourite_movie_cell_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Image.network(
              movie.posterUrl,
              alignment: Alignment(horizontalSlide, 1),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Flexible(child: detailsView(context, movie))
      ],
    );
  }

  Widget detailsView(BuildContext context, Movie movie) {
    return Consumer<FavouritesMovieCellViewModel>(builder: (_, viewModel, __) {
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
                onTab: () =>
                    {AppRouter.launchURL(viewModel.currentMovieTrailerUrl)},
              ),
              CinespotButtonView(
                title: "Recommend",
                onTab: () => {Share.share(viewModel.currentMovieTrailerUrl)},
              ),
              IconButton(
                onPressed: () => {viewModel.removeFromFavourites()},
                icon: Icon(CupertinoIcons.heart),
                isSelected: viewModel.isMovieFavourite,
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
    });
  }
}
