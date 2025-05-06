part of 'movie_details_bloc.dart';

class MovieDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadInitialMovieData extends MovieDetailsEvent {}

class AddToFavourites extends MovieDetailsEvent {}

class RemoveFromFavourites extends MovieDetailsEvent {}

class FetchFavouriteMovies extends MovieDetailsEvent {}

class FetchTrailerForMovie extends MovieDetailsEvent {
  final String movieId;

  FetchTrailerForMovie(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class FavouritesUpdated extends MovieDetailsEvent {
  final List<Movie> movies;
  FavouritesUpdated(this.movies);

  @override
  List<Object?> get props => [movies];
}

class SelectProductionType extends MovieDetailsEvent {
  final ProductionType type;
  SelectProductionType(this.type);
  @override
  List<Object?> get props => [type];
}
