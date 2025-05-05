part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Movie> movies;
  final List<MovieCategory> categories;
  final MovieCategory currentCategory;
  final bool isLoading;
  final bool isLoadingTrailer;
  final Movie? movieOfTheDay;
  final String trailerUrl;
  final bool hasNextPage;

  const HomeState({
    this.movies = const [],
    this.categories = MovieCategory.values,
    this.currentCategory = MovieCategory.upcoming,
    this.isLoading = false,
    this.isLoadingTrailer = false,
    this.movieOfTheDay,
    this.trailerUrl = '',
    this.hasNextPage = true,
  });

  HomeState copyWith({
    List<Movie>? movies,
    List<MovieCategory>? categories,
    MovieCategory? currentCategory,
    bool? isLoading,
    bool? isLoadingTrailer,
    Movie? movieOfTheDay,
    String? trailerUrl,
    bool? hasNextPage,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
      categories: categories ?? this.categories,
      currentCategory: currentCategory ?? this.currentCategory,
      isLoading: isLoading ?? this.isLoading,
      isLoadingTrailer: isLoadingTrailer ?? this.isLoadingTrailer,
      movieOfTheDay: movieOfTheDay ?? this.movieOfTheDay,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
        movies,
        categories,
        currentCategory,
        isLoading,
        isLoadingTrailer,
        movieOfTheDay,
        trailerUrl,
        hasNextPage,
      ];
}
