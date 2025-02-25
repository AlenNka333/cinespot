import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/managers/content_manager.dart';
import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/data/network/models/video.dart';
import 'package:flutter/material.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  final AuthenticationManager _authManager;

  int page = 1;
  late Movie _selectedMovie;
  Movie get selectedMovie => _selectedMovie;

  set selectedMovie(Movie value) {
    _selectedMovie = value;
    notifyListeners();
  }

  Video? _currentMovieTrailer;
  String get currentMovieTrailerUrl {
    return _currentMovieTrailer?.videoUrl ?? "";
  }

  bool isLoading = true;
  bool get isMovieFavourite =>
      ContentManager().isMovieFavourite(selectedMovie.id);
  bool isTrailerAvailable = false;

  ProductionType _selectedType = ProductionType.companies;
  ProductionType get selectedType => _selectedType;
  set selectedType(ProductionType value) {
    _selectedType = value;
    notifyListeners();
  }

  MovieDetailsViewModel(this._authManager, {required Movie selectedMovie}) {
    _selectedMovie = selectedMovie;
    ContentManager().addListener(_onFavouritesUpdated);
    fetchMovieDetails();
    fetchFavouriteMovies();
  }

  @override
  void dispose() {
    ContentManager().removeListener(_onFavouritesUpdated);
    super.dispose();
  }

  void _onFavouritesUpdated() {
    notifyListeners();
  }

  void fetchMovieDetails() async {
    isLoading = true;
    notifyListeners();

    try {
      _selectedMovie =
          await APIClient().fetchMovie(id: selectedMovie.id.toString()) ??
              selectedMovie;
    } catch (error) {
      print(error.toString());
    } finally {
      fetchMovieVideos(movieId: selectedMovie.id.toString());
    }
  }

  void fetchMovieVideos({required String movieId}) async {
    try {
      List<Video> videos = await APIClient().fetchMovieVideo(movieId: movieId);

      if (videos.isNotEmpty) {
        _currentMovieTrailer = videos.first;
        isTrailerAvailable = true;
      }
    } catch (error) {
      print(error.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addToFavourites() async {
    if (_authManager.account?.accountId == null) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      bool movieAdded = await APIClient().addToFavourites(
          accountId: _authManager.account!.accountId,
          movieId: _selectedMovie.id);

      if (movieAdded) {
        ContentManager().addToFavourites(selectedMovie);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  void removeFromFavourites() async {
    if (_authManager.account?.accountId == null) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      bool movieRemoved = await APIClient().removeFromFavourites(
          accountId: _authManager.account!.accountId,
          movieId: _selectedMovie.id);

      if (movieRemoved) {
        ContentManager().removeFromFavourites(selectedMovie.id);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  void fetchFavouriteMovies() async {
    if (_authManager.account?.accountId == null) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      ContentManager().favouriteMovies = await APIClient().fetchFavouriteMovies(
          page: 1.toString(), accountId: _authManager.account!.accountId);
    } catch (error) {
      print(error.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
