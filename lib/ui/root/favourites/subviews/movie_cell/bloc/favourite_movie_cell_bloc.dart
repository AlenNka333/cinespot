import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/managers/content_manager.dart';
import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/video.dart';

part 'favourite_movie_cell_event.dart';
part 'favourite_movie_cell_state.dart';

class FavouriteMovieCellBloc
    extends Bloc<FavouriteMovieCellEvent, FavouriteMovieCellState> {
  final AuthenticationManager _authManager;
  final int movieId;

  FavouriteMovieCellBloc(this._authManager, this.movieId)
      : super(FavouriteMovieCellInitial()) {
    on<LoadMovieVideos>(_onLoadMovieVideos);
    on<RemoveMovieFromFavourites>(_onRemoveFromFavourites);
    on<FavouritesContentUpdated>(_onContentUpdated);

    ContentManager().addListener(_handleContentUpdate);
  }

  void _handleContentUpdate() {
    add(FavouritesContentUpdated());
  }

  Future<void> _onLoadMovieVideos(
      LoadMovieVideos event, Emitter<FavouriteMovieCellState> emit) async {
    try {
      List<Video> videos =
          await APIClient().fetchMovieVideo(movieId: movieId.toString());

      if (videos.isNotEmpty) {
        emit(FavouriteMovieCellLoaded(trailerUrl: videos.first.videoUrl ?? ""));
      } else {
        emit(FavouriteMovieCellLoaded(trailerUrl: ""));
      }
    } catch (error) {
      emit(FavouriteMovieCellError(error.toString()));
    }
  }

  Future<void> _onRemoveFromFavourites(RemoveMovieFromFavourites event,
      Emitter<FavouriteMovieCellState> emit) async {
    try {
      bool movieRemoved = await APIClient().removeFromFavourites(
        movieId: movieId,
        accountId: _authManager.account!.accountId,
      );

      if (movieRemoved) {
        ContentManager().removeFromFavourites(movieId);
      }
    } catch (error) {
      emit(FavouriteMovieCellError(error.toString()));
    }
  }

  void _onContentUpdated(
      FavouritesContentUpdated event, Emitter<FavouriteMovieCellState> emit) {
    emit(state); // Просто обновляем, чтобы BlocBuilder перерисовался
  }

  bool get isMovieFavourite => ContentManager().isMovieFavourite(movieId);

  @override
  Future<void> close() {
    ContentManager().removeListener(_handleContentUpdate);
    return super.close();
  }
}
