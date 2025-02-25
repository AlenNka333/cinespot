import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/managers/content_manager.dart';
import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:flutter/cupertino.dart';

class FavouritesViewModel extends ChangeNotifier {
  final AuthenticationManager _authManager;

  late PageController _pageController;
  double _page = 0.0;
  PageController get pageController => _pageController;
  double get page => _page;

  bool isLoading = false;

  List<Movie> favouriteMovies = [];

  FavouritesViewModel(this._authManager) {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
    _pageController.addListener(_onScroll);
    ContentManager().addListener(_onFavouritesUpdated);
    fetchFavouriteMovies();
  }

  void _onScroll() {
    _page = _pageController.page ?? 0.0;
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    ContentManager().removeListener(_onFavouritesUpdated);
    super.dispose();
  }

  void _onFavouritesUpdated() {
    favouriteMovies = ContentManager().favouriteMovies;
    notifyListeners();
  }

  void fetchFavouriteMovies() async {
    if (_authManager.account?.accountId == null) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      List<Movie> movies = await APIClient().fetchFavouriteMovies(
          page: '1', accountId: _authManager.account!.accountId);
      ContentManager().favouriteMovies = movies;
      notifyListeners();
    } catch (error) {
      print(error.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
