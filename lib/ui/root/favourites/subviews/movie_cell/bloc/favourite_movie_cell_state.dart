part of 'favourite_movie_cell_bloc.dart';

abstract class FavouriteMovieCellState extends Equatable {
  const FavouriteMovieCellState();

  @override
  List<Object?> get props => [];
}

class FavouriteMovieCellInitial extends FavouriteMovieCellState {}

class FavouriteMovieCellLoaded extends FavouriteMovieCellState {
  final String trailerUrl;

  const FavouriteMovieCellLoaded({required this.trailerUrl});

  @override
  List<Object?> get props => [trailerUrl];
}

class FavouriteMovieCellError extends FavouriteMovieCellState {
  final String message;

  const FavouriteMovieCellError(this.message);

  @override
  List<Object?> get props => [message];
}
