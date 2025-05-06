part of 'favourites_bloc.dart';

class FavouritesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavourites extends FavouritesEvent {}

class FavouritesUpdated extends FavouritesEvent {
  final List<Movie> movies;
  FavouritesUpdated(this.movies);

  @override
  List<Object?> get props => [movies];
}
