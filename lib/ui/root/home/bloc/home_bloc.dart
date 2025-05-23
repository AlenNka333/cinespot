import 'dart:math';

import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/data/network/models/video.dart';
import 'package:cinespot/data/services/global_error_handler_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int _page = 1;

  HomeBloc() : super(const HomeState()) {
    on<LoadInitialData>(_onLoadInitialData);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<FetchTrailerForMovie>(_onFetchTrailerForMovie);
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onLoadInitialData(
      LoadInitialData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    _page = 1;

    try {
      final movies = await APIClient()
          .getMovies(category: state.currentCategory.rawValue, page: _page);

      final hasNextPage = movies.length >= 20;
      final randomMovie = _getRandomMovie(movies);

      emit(state.copyWith(
        movies: movies,
        movieOfTheDay: randomMovie,
        isLoading: false,
        hasNextPage: hasNextPage,
      ));

      if (randomMovie != null) {
        add(FetchTrailerForMovie(randomMovie.id.toString()));
      }
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onLoadMoreMovies(
      LoadMoreMovies event, Emitter<HomeState> emit) async {
    if (!state.hasNextPage || state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    try {
      _page++;
      final newMovies = await APIClient()
          .getMovies(category: state.currentCategory.rawValue, page: _page);

      final hasNextPage = newMovies.length >= 20;

      emit(state.copyWith(
        movies: [...state.movies, ...newMovies],
        isLoading: false,
        hasNextPage: hasNextPage,
      ));
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onSelectCategory(
      SelectCategory event, Emitter<HomeState> emit) async {
    final newCategory = state.categories[event.index];

    emit(state.copyWith(
        currentCategory: newCategory,
        isLoading: true,
        movies: [],
        hasNextPage: true));

    _page = 1;

    try {
      final movies = await APIClient()
          .getMovies(category: state.currentCategory.rawValue, page: _page);

      final hasNextPage = movies.length >= 20;

      emit(state.copyWith(
        movies: movies,
        isLoading: false,
        hasNextPage: hasNextPage,
      ));
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onFetchTrailerForMovie(
      FetchTrailerForMovie event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoadingTrailer: true));

    try {
      List<Video> videos =
          await APIClient().fetchMovieVideo(movieId: event.movieId);

      if (videos.isNotEmpty) {
        emit(state.copyWith(
            trailerUrl: videos.first.videoUrl, isLoadingTrailer: false));
      } else {
        emit(state.copyWith(isLoadingTrailer: false));
      }
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(state.copyWith(isLoadingTrailer: false));
    }
  }

  Movie? _getRandomMovie(List<Movie> movies) {
    if (movies.isNotEmpty) {
      return movies[Random().nextInt(movies.length)];
    } else {
      return null;
    }
  }
}
