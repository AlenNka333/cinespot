part of 'favourites_bloc.dart';

class FavouritesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<Movie> movies;
  FavouritesLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class FavouritesEmpty extends FavouritesState {}

class FetchingFavouritesFailed extends FavouritesState {
  final String error;
  FetchingFavouritesFailed(this.error);

  @override
  List<Object?> get props => [error];
}
