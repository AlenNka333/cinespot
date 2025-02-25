import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/root/favourites/subviews/favourite_movie_cell_view_model.dart';
import 'package:cinespot/ui/root/favourites/subviews/parallax_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FavouriteMovieCell extends StatelessWidget {
  final int index;
  final Movie movie;
  final double page;

  const FavouriteMovieCell({
    super.key,
    required this.index,
    required this.movie,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavouritesMovieCellViewModel(
          context.read<AuthenticationManager>(), movie.id),
      child: Consumer<FavouritesMovieCellViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ParallaxImage(
              movie: movie,
              horizontalSlide: (index - page).clamp(-1, 1).toDouble(),
            ),
          );
        },
      ),
    );
  }
}
