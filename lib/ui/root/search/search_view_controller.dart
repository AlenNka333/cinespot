import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinespot/utils/extensions/double_extension.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/root/search/search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';

class SearchViewController extends StatelessWidget {
  const SearchViewController({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child:
        SafeArea(child: Consumer<SearchViewModel>(builder: (_, viewModel, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          spacing: 10,
          children: [
            textField(
                controller: viewModel.searchController,
                placeholder: "Movie name"),
            textField(
                controller: viewModel.yearController,
                placeholder: "Release year"),
            SizedBox(
              height: 10,
            ),
            Expanded(child: moviesView(context))
          ],
        ),
      );
    })));
  }

  Widget textField(
      {required TextEditingController controller,
      required String placeholder}) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      padding: const EdgeInsets.all(16),
      style: const TextStyle(color: CupertinoColors.white),
      placeholderStyle:
          const TextStyle(color: Color.fromARGB(255, 196, 195, 220)),
      decoration: const BoxDecoration(
          color: Color.fromARGB(34, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  Widget moviesView(BuildContext context) {
    return Selector<SearchViewModel, List<Movie>>(
      selector: (_, viewModel) => viewModel.movies,
      builder: (_, movies, __) {
        if (movies.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.search,
                    size: 60, color: CupertinoColors.systemGrey),
                SizedBox(height: 10),
                Text(
                  "No movies found",
                  style: TextStyle(
                      color: CupertinoColors.systemGrey, fontSize: 18),
                )
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: movies.map((movie) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 5.0,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: imageView(movie.posterUrl),
                      ),
                    ),
                    AutoSizeText(
                      movie.title.toString(),
                      style: TextStyle(fontWeight: FontWeight.w400),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      minFontSize: 10,
                      maxFontSize: 15,
                    ),
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child: StarRating(
                        rating: movie.voteAverage.halfRating(),
                        allowHalfRating: true,
                        color: Colors.amber,
                        borderColor: Color.fromRGBO(87, 111, 130, 1),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget imageView(String url) {
    if (url.isEmpty) {
      return Icon(CupertinoIcons.film_fill);
    }

    return Image.network(
      url,
      fit: BoxFit.cover,
    );
  }
}
