import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/managers/content_manager.dart';
import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/data/services/global_error_handler_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'favourites_state.dart';
part 'favourites_event.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final AuthenticationManager _authManager;

  FavouritesBloc(this._authManager) : super(FavouritesInitial()) {
    on<LoadFavourites>(_onFetchFavourites);
    on<FavouritesUpdated>(_onFavouritesUpdatedEvent);
    ContentManager().addListener(_handleContentUpdate);
  }

  void _handleContentUpdate() {
    add(FavouritesUpdated(ContentManager().favouriteMovies));
  }

  void _onFavouritesUpdatedEvent(
      FavouritesUpdated event, Emitter<FavouritesState> emit) {
    if (event.movies.isEmpty) {
      emit(FavouritesEmpty());
    } else {
      emit(FavouritesLoaded(event.movies));
    }
  }

  Future<void> _onFetchFavourites(
      LoadFavourites event, Emitter<FavouritesState> emit) async {
    if (_authManager.account?.accountId == null) {
      return;
    }

    emit(FavouritesLoading());

    try {
      List<Movie> movies = await APIClient().fetchFavouriteMovies(
          page: '1', accountId: _authManager.account!.accountId);
      ContentManager().favouriteMovies = movies;
      emit(FavouritesLoaded(movies));
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(FetchingFavouritesFailed(error.toString()));
    }
  }

  @override
  Future<void> close() {
    ContentManager().removeListener(_handleContentUpdate);
    return super.close();
  }
}
