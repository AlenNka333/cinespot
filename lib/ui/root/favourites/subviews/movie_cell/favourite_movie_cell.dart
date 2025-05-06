import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/root/favourites/subviews/movie_cell/bloc/favourite_movie_cell_bloc.dart';
import 'package:cinespot/ui/root/favourites/widgets/parallax_image.dart';
import 'package:cinespot/data/managers/authentication_manager.dart';

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
    return BlocProvider(
      create: (context) {
        final bloc = FavouriteMovieCellBloc(
            context.read<AuthenticationManager>(), movie.id);
        bloc.add(LoadMovieVideos());
        return bloc;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ParallaxImage(
          movie: movie,
          horizontalSlide: (index - page).clamp(-1, 1).toDouble(),
        ),
      ),
    );
  }
}
