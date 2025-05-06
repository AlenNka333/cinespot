import 'package:cinespot/ui/common/subviews/sized_activity_indicator.dart';
import 'package:cinespot/ui/root/home/bloc/home_bloc.dart';
import 'package:cinespot/ui/root/home/subviews/movie_of_the_day_view.dart';
import 'package:cinespot/ui/root/home/subviews/categories_list.dart';
import 'package:cinespot/ui/root/home/subviews/movies_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewController extends StatelessWidget {
  const HomeViewController({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                child: const Text(
                  "Movie of the day",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 25),
                ),
              ),
              if (state.isLoading && state.movieOfTheDay == null)
                SizedActivityIndicator(
                  height: MediaQuery.of(context).size.height / 2.8,
                  width: MediaQuery.of(context).size.width,
                )
              else if (state.movieOfTheDay != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2.8,
                    width: MediaQuery.of(context).size.width,
                    child: MovieOfTheDayView(movie: state.movieOfTheDay!),
                  ),
                ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: CategoriesList(),
              ),
              Expanded(
                child: state.isLoading && state.movies.isEmpty
                    ? SizedActivityIndicator(
                        height: MediaQuery.of(context).size.height / 2.8,
                        width: MediaQuery.of(context).size.width,
                      )
                    : MoviesListView(),
              ),
            ],
          );
        },
      ),
    ));
  }
}
