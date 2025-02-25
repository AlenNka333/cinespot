import 'dart:async';

import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:flutter/cupertino.dart';

class SearchViewModel extends ChangeNotifier {
  late TextEditingController _searchController;
  late TextEditingController _yearController;
  Timer? _debounce;

  TextEditingController get searchController => _searchController;
  TextEditingController get yearController => _yearController;

  List<Movie> movies = [];

  bool isLoading = false;

  SearchViewModel() {
    _searchController = TextEditingController();
    _yearController = TextEditingController();

    _searchController.addListener(_onSearchChanged);
    _yearController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 3), () {
      _fetchMovies();
    });
  }

  void _fetchMovies() {
    String query = _searchController.text.trim();
    String year = _yearController.text.trim();

    if (query.isEmpty && year.isNotEmpty) {
      _fetchMoviesByYear(year);
    } else if (query.isNotEmpty) {
      _fetchMoviesByName(query, year);
    } else {
      //_errorMessage = "Please, check your input";
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _yearController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _fetchMoviesByYear(String year) async {
    isLoading = true;
    notifyListeners();

    try {
      movies = await APIClient().fetchMoviesByYear(year: year);
    } catch (error) {
      //_errorMessage = error.toString();
      print(error.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchMoviesByName(String query, String? year) async {
    isLoading = true;
    notifyListeners();

    try {
      movies = await APIClient().fetchMoviesBy(query: query, year: year);
    } catch (error) {
      //_errorMessage = error.toString();
      print(error.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
