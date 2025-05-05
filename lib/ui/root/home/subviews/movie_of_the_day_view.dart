import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:cinespot/ui/root/home/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';

class MovieOfTheDayView extends StatelessWidget {
  final Movie movie;
  const MovieOfTheDayView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10.0,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      movie.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.white),
                      textAlign: TextAlign.center,
                      minFontSize: 10,
                      maxFontSize: 18,
                    ),
                    SizedBox(height: 8),
                    AutoSizeText(
                      movie.overview,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: CupertinoColors.white),
                      textAlign: TextAlign.center,
                      minFontSize: 8,
                      maxFontSize: 13,
                    ),
                    SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: StarRating(
                        rating: movie.voteAverage ?? 0,
                        allowHalfRating: true,
                        color: Colors.amber,
                        borderColor: Color.fromRGBO(87, 111, 130, 1),
                      ),
                    )
                  ],
                ),
              ),
              BlocSelector<HomeBloc, HomeState, String>(
                selector: (state) => state.trailerUrl,
                builder: (context, trailerUrl) {
                  if (trailerUrl.isNotEmpty) {
                    return TextButton(
                      onPressed: () => AppRouter.launchURL(trailerUrl),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(58, 75, 93, 1)),
                      child: Text(
                          style: TextStyle(fontWeight: FontWeight.normal),
                          "Watch trailer".toUpperCase()),
                    );
                  } else {
                    return SizedBox(
                      height: 10,
                    );
                  }
                },
              )
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.network(movie.posterUrl, fit: BoxFit.fitHeight),
          ),
        ),
      ],
    );
  }
}
