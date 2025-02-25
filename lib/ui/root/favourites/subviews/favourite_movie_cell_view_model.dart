import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/managers/content_manager.dart';
import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/video.dart';
import 'package:flutter/cupertino.dart';

class FavouritesMovieCellViewModel extends ChangeNotifier {
  final AuthenticationManager _authManager;
  final int movieId;

  Video? _currentMovieTrailer;
  String get currentMovieTrailerUrl {
    return _currentMovieTrailer?.videoUrl ?? "";
  }

  bool get isMovieFavourite {
    return ContentManager().isMovieFavourite(movieId);
  }

  bool isTrailerAvailable = false;

  FavouritesMovieCellViewModel(this._authManager, this.movieId) {
    ContentManager().addListener(_onFavouritesUpdate);
    fetchMovieVideos();
  }

  @override
  void dispose() {
    ContentManager().removeListener(_onFavouritesUpdate);
    super.dispose();
  }

  void _onFavouritesUpdate() {
    notifyListeners();
  }

  void fetchMovieVideos() async {
    try {
      List<Video> videos =
          await APIClient().fetchMovieVideo(movieId: movieId.toString());

      if (videos.isNotEmpty) {
        _currentMovieTrailer = videos.first;
        isTrailerAvailable = true;
      }
    } catch (error) {
      print(error.toString());
    }
  }

  void removeFromFavourites() async {
    if (_authManager.account?.accountId == null) {
      return;
    }

    try {
      bool movieRemoved = await APIClient().removeFromFavourites(
          movieId: movieId, accountId: _authManager.account!.accountId);

      if (movieRemoved) {
        ContentManager().removeFromFavourites(movieId);
        ContentManager().notifyListeners();
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
