import 'dart:async';

import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/data/services/global_error_handler_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  Timer? _debounce;

  SearchBloc() : super(SearchInitial()) {
    on<SearchQueryChanged>(_onChanged);
    on<SearchMovieRequested>(_onSearchRequested);
  }

  void _onChanged(SearchQueryChanged event, Emitter<SearchState> emit) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 3), () {
      add(SearchMovieRequested(movieName: event.movieName, year: event.year));
    });
  }

  void _onSearchRequested(
      SearchMovieRequested event, Emitter<SearchState> emit) async {
    String query = event.movieName.trim();
    String year = event.year.trim();

    emit(SearchLoading());

    try {
      List<Movie> movies;
      if (query.isEmpty && year.isNotEmpty) {
        movies = await APIClient().fetchMoviesByYear(year: year);
      } else if (query.isNotEmpty) {
        movies = await APIClient().fetchMoviesBy(query: query, year: year);
      } else {
        movies = [];
      }

      emit(SearchLoaded(movies: movies));
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(SearchFailed(error.toString()));
    }
  }
}
