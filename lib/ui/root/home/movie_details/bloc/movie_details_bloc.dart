import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/managers/content_manager.dart';
import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/data/network/models/video.dart';
import 'package:cinespot/data/services/global_error_handler_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final AuthenticationManager _authManager;

  MovieDetailsBloc(this._authManager, Movie selectedMovie)
      : super(MovieDetailsState(selectedMovie: selectedMovie)) {
    on<LoadInitialMovieData>(_onLoadInitialData);
    on<AddToFavourites>(_onAddToFavourites);
    on<RemoveFromFavourites>(_onRemoveFromFavourites);
    on<FetchFavouriteMovies>(_onFetchFavouriteMovies);
    on<FetchTrailerForMovie>(_onFetchTrailerForMovie);
    on<FavouritesUpdated>(_onFavouritesUpdatedEvent);
    on<SelectProductionType>(_onSelectProductionType);
    ContentManager().addListener(_handleContentUpdate);
  }

  void _handleContentUpdate() {
    add(FavouritesUpdated(ContentManager().favouriteMovies));
  }

  void _onSelectProductionType(
      SelectProductionType event, Emitter<MovieDetailsState> emit) {
    emit(state.copyWith(selectedType: event.type));
  }

  void _onFavouritesUpdatedEvent(
      FavouritesUpdated event, Emitter<MovieDetailsState> emit) {
    final isFavourite = event.movies.any((m) => m.id == state.selectedMovie.id);
    emit(state.copyWith(isMovieFavourite: isFavourite));
  }

  Future<void> _onLoadInitialData(
      LoadInitialMovieData event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      Movie? selectedMovie =
          await APIClient().fetchMovie(id: state.selectedMovie.id.toString()) ??
              state.selectedMovie;
      emit(state.copyWith(isLoading: false, selectedMovie: selectedMovie));
      add(FetchTrailerForMovie(state.selectedMovie.id.toString()));
      add(FetchFavouriteMovies());
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onFetchTrailerForMovie(
      FetchTrailerForMovie event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      List<Video> videos =
          await APIClient().fetchMovieVideo(movieId: event.movieId);

      if (videos.isNotEmpty) {
        emit(state.copyWith(
            trailerUrl: videos.first.videoUrl,
            isTrailerAvailable: true,
            isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onAddToFavourites(
      AddToFavourites event, Emitter<MovieDetailsState> emit) async {
    if (_authManager.account?.accountId == null) {
      return;
    }

    try {
      bool movieAdded = await APIClient().addToFavourites(
          accountId: _authManager.account!.accountId,
          movieId: state.selectedMovie.id);

      if (movieAdded) {
        ContentManager().addToFavourites(state.selectedMovie);
      }
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(state.copyWith());
    }
  }

  Future<void> _onRemoveFromFavourites(
      RemoveFromFavourites event, Emitter<MovieDetailsState> emit) async {
    if (_authManager.account?.accountId == null) {
      return;
    }

    try {
      bool movieAdded = await APIClient().removeFromFavourites(
          accountId: _authManager.account!.accountId,
          movieId: state.selectedMovie.id);

      if (movieAdded) {
        ContentManager().removeFromFavourites(state.selectedMovie.id);
      }
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(state.copyWith());
    }
  }

  Future<void> _onFetchFavouriteMovies(
      FetchFavouriteMovies event, Emitter<MovieDetailsState> emit) async {
    if (_authManager.account?.accountId == null) {
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      ContentManager().favouriteMovies = await APIClient().fetchFavouriteMovies(
          page: "1", accountId: _authManager.account!.accountId);

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(state.copyWith(isLoading: false));
    }
  }

  @override
  Future<void> close() {
    ContentManager().removeListener(_handleContentUpdate);
    return super.close();
  }
}
