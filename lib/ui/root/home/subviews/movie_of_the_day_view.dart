import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:cinespot/ui/root/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';

class MovieOfTheDayView extends StatelessWidget {
  final Movie movie;
  const MovieOfTheDayView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.0,
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
                  spacing: 8.0,
                  children: [
                    AutoSizeText(
                      movie.title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                      minFontSize: 10,
                      maxFontSize: 18,
                    ),
                    AutoSizeText(
                      movie.overview,
                      style: TextStyle(fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                      minFontSize: 8,
                      maxFontSize: 13,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: StarRating(
                        rating: movie.voteAverage,
                        allowHalfRating: true,
                        color: Colors.amber,
                        borderColor: Color.fromRGBO(87, 111, 130, 1),
                      ),
                    )
                  ],
                ),
              ),
              Consumer<HomeViewModel>(
                builder: (_, viewModel, __) {
                  if (viewModel.isTrailerAvailable) {
                    return TextButton(
                      onPressed: () =>
                          AppRouter.launchURL(viewModel.currentMovieTrailerUrl),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(58, 75, 93, 1)),
                      child: Text(
                          style: TextStyle(fontWeight: FontWeight.normal),
                          "Whatch trailer".toUpperCase()),
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
