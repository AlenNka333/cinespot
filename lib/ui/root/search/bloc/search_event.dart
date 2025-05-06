part of 'search_block.dart';

class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String movieName;
  final String year;

  SearchQueryChanged({required this.movieName, required this.year});

  @override
  List<Object?> get props => [movieName, year];
}

class SearchMovieRequested extends SearchEvent {
  final String movieName;
  final String year;

  SearchMovieRequested({required this.movieName, required this.year});

  @override
  List<Object?> get props => [movieName, year];
}
