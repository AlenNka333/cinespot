import 'dart:math';

import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/data/network/models/video.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  List<Movie> movies = [];
  List<MovieCategory> categories = MovieCategory.values;

  MovieCategory _currentCategory = MovieCategory.upcoming;
  MovieCategory get currentCategory => _currentCategory;

  Movie? _randomMovie;
  Movie? get movieOfTheDay => _randomMovie;

  Video? _currentMovieTrailer;
  String get currentMovieTrailerUrl {
    return _currentMovieTrailer?.videoUrl ?? "";
  }

  int page = 1;
  bool hasNextPage = true;
  bool isLoading = true;
  bool isLoadingCurrentMovie = true;
  bool isTrailerAvailable = false;

  HomeViewModel() {
    scrollController.addListener(_scrollListener);
    fetchMovies(fromStart: true);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreMovies();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchMovies({bool fromStart = false}) async {
    if (fromStart) {
      page = 1;
      hasNextPage = true;
      isLoading = true;
      if (_randomMovie == null) {
        isLoadingCurrentMovie = true;
      }
      notifyListeners();
    }

    try {
      if (hasNextPage) {
        List<Movie> newMovies = await APIClient()
            .getMovies(category: _currentCategory.rawValue, page: page);

        if (newMovies.length < 20) {
          hasNextPage = false;
        }

        if (page == 1) {
          movies = newMovies;
        } else {
          movies += newMovies;
        }

        page += 1;
      } else {
        return;
      }
    } catch (error) {
      print(error.toString());
    } finally {
      isLoading = false;
      if (_randomMovie == null) {
        _randomMovie ??= _getRandomMovie();
        fetchMovieVideos(movieId: _randomMovie?.id.toString() ?? "");
      }
      notifyListeners();
    }
  }

  void loadMoreMovies() {
    fetchMovies();
  }

  Future<void> fetchMovieVideos({required String movieId}) async {
    try {
      List<Video> videos = await APIClient().fetchMovieVideo(movieId: movieId);

      if (videos.isNotEmpty) {
        _currentMovieTrailer = videos.first;
        isTrailerAvailable = true;
      }
    } catch (error) {
      print(error.toString());
    } finally {
      isLoadingCurrentMovie = false;
      notifyListeners();
    }
  }

  void selectCategory({required int index}) {
    _currentCategory = categories[index];
    page = 1;
    hasNextPage = true;
    notifyListeners();
    fetchMovies();
  }

  Movie? _getRandomMovie() {
    if (movies.isNotEmpty) {
      return movies[Random().nextInt(movies.length)];
    } else {
      return null;
    }
  }
}
