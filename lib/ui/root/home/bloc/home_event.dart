part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadInitialData extends HomeEvent {}

class LoadMoreMovies extends HomeEvent {}

class SelectCategory extends HomeEvent {
  final int index;

  SelectCategory(this.index);

  @override
  List<Object?> get props => [index];
}

class FetchTrailerForMovie extends HomeEvent {
  final String movieId;

  FetchTrailerForMovie(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
