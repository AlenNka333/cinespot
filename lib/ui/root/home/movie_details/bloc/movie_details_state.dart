part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  final bool isLoading;
  final Movie selectedMovie;
  final String trailerUrl;
  final bool isTrailerAvailable;
  final bool isMovieFavourite;
  final ProductionType selectedType;

  const MovieDetailsState(
      {this.isLoading = false,
      required this.selectedMovie,
      this.trailerUrl = '',
      this.isTrailerAvailable = false,
      this.isMovieFavourite = false,
      this.selectedType = ProductionType.companies});

  MovieDetailsState copyWith({
    bool? isLoading,
    Movie? selectedMovie,
    String? trailerUrl,
    bool? isTrailerAvailable,
    bool? isMovieFavourite,
    ProductionType? selectedType,
  }) {
    return MovieDetailsState(
      isLoading: isLoading ?? this.isLoading,
      selectedMovie: selectedMovie ?? this.selectedMovie,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      isTrailerAvailable: isTrailerAvailable ?? this.isTrailerAvailable,
      isMovieFavourite: isMovieFavourite ?? this.isMovieFavourite,
      selectedType: selectedType ?? this.selectedType,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        selectedMovie,
        trailerUrl,
        isTrailerAvailable,
        isMovieFavourite,
        selectedType,
      ];
}
