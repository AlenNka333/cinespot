part of 'search_block.dart';

class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  List<Movie> movies;

  SearchLoaded({required this.movies});

  @override
  List<Object?> get props => [movies];
}

class SearchFailed extends SearchState {
  final String error;
  SearchFailed(this.error);
  @override
  List<Object?> get props => [error];
}
