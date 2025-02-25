import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinespot/core/app_style.dart';
import 'package:cinespot/data/network/models/company.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:cinespot/ui/common/subviews/cinespot_button_view.dart';
import 'package:cinespot/ui/common/subviews/favourite_button_view.dart';
import 'package:cinespot/ui/root/home/movie_details_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailsViewController extends StatelessWidget {
  const MovieDetailsViewController({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MovieDetailsViewModel>(context);

    return CupertinoTheme(
      data: CupertinoThemeData(
        primaryColor: Colors.white,
      ),
      child: CupertinoPageScaffold(
          backgroundColor: AppStyle.appTheme.scaffoldBackgroundColor,
          navigationBar: CupertinoNavigationBar(
            automaticBackgroundVisibility: false,
            enableBackgroundFilterBlur: false,
            backgroundColor: Colors.transparent,
            border: Border(),
          ),
          child: SingleChildScrollView(
            child: SafeArea(
                top: false,
                child: Column(
                  spacing: 20,
                  children: [
                    Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2.2,
                        width: MediaQuery.of(context).size.width,
                        foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppStyle.appTheme.scaffoldBackgroundColor
                                .withOpacity(0.7),
                            AppStyle.appTheme.scaffoldBackgroundColor
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.8, 0.9, 1.0],
                        )),
                        child:
                            backdropView(viewModel.selectedMovie.backdropUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              descriptionView(viewModel.selectedMovie),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CinespotButtonView(
                                    title: "Watch trailer",
                                    onTab: () => {
                                      AppRouter.launchURL(
                                          viewModel.currentMovieTrailerUrl)
                                    },
                                  ),
                                  FavouriteButtonView(
                                      onPressed: () => {
                                            if (viewModel.isMovieFavourite)
                                              {viewModel.removeFromFavourites()}
                                            else
                                              {viewModel.addToFavourites()}
                                          },
                                      isSelected: viewModel.isMovieFavourite)
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: AutoSizeText(
                        viewModel.selectedMovie.overview,
                        style: TextStyle(fontWeight: FontWeight.w300),
                        minFontSize: 10,
                        maxFontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Production companies",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: companiesView()),
                  ],
                )),
          )),
    );
  }

  Widget descriptionView(Movie movie) {
    return Wrap(
      children: [
        AutoSizeText(
          movie.title.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          minFontSize: 25,
          maxFontSize: 30,
        ),
        AutoSizeText(
          movie.movieReleaseDescription(),
          style: TextStyle(fontWeight: FontWeight.w300),
          maxLines: 2,
          minFontSize: 15,
          maxFontSize: 20,
        ),
        AutoSizeText(
          movie.moviePopularityDescription(),
          style: TextStyle(fontWeight: FontWeight.w300),
          maxLines: 2,
          minFontSize: 15,
          maxFontSize: 20,
        ),
      ],
    );
  }

  Widget backdropView(String url) {
    if (url.isEmpty) {
      return Icon(CupertinoIcons.film_fill);
    }

    return Image.network(url, fit: BoxFit.cover);
  }

  Widget companiesView() {
    return Selector<MovieDetailsViewModel, List<Company>>(
      selector: (_, viewModel) => viewModel.selectedMovie.companies ?? [],
      builder: (_, companies, __) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: companies.map((company) {
              return Column(
                spacing: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child:
                        company.logoPath != null && company.logoPath!.isNotEmpty
                            ? Image.network(
                                company.logoPath!,
                                fit: BoxFit.fitWidth,
                              )
                            : Icon(CupertinoIcons.photo, size: 40),
                  ),
                  SizedBox(
                    width: 80,
                    child: Divider(),
                  ),
                  SizedBox(
                    width: 80,
                    child: AutoSizeText(
                      company.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w300),
                      maxLines: 2,
                      minFontSize: 15,
                      maxFontSize: 15,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
