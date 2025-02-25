import 'package:cinespot/data/network/models/movie.dart';
import 'package:flutter/cupertino.dart';

class ContentManager extends ChangeNotifier {
  static final ContentManager _contentManager = ContentManager._internal();

  List<Movie> _favouriteMovies = [];
  List<Movie> get favouriteMovies => _favouriteMovies;
  set favouriteMovies(List<Movie> movies) {
    _favouriteMovies = movies;
    notifyListeners();
  }

  bool isMovieFavourite(int movieId) {
    return favouriteMovies.any((movie) => movie.id == movieId);
  }

  factory ContentManager() {
    return _contentManager;
  }

  ContentManager._internal();

  void addToFavourites(Movie movie) {
    if (!favouriteMovies.contains(movie)) {
      favouriteMovies = List.from(_favouriteMovies)..add(movie);
      notifyListeners();
    }
  }

  void removeFromFavourites(int movieId) {
    if (favouriteMovies.any((movie) => movie.id == movieId)) {
      favouriteMovies = List.from(_favouriteMovies)
        ..removeWhere((movie) => movie.id == movieId);
      notifyListeners();
    }
  }
}
