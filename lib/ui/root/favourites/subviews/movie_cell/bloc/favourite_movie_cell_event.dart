part of 'favourite_movie_cell_bloc.dart';

abstract class FavouriteMovieCellEvent extends Equatable {
  const FavouriteMovieCellEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovieVideos extends FavouriteMovieCellEvent {}

class RemoveMovieFromFavourites extends FavouriteMovieCellEvent {}

class FavouritesContentUpdated extends FavouriteMovieCellEvent {}
