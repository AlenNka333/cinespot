import 'package:cinespot/ui/root/favourites/favourites_view_model.dart';
import 'package:cinespot/ui/root/favourites/subviews/favourite_movie_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FavouritesViewController extends StatelessWidget {
  const FavouritesViewController({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return CupertinoPageScaffold(
      child: SafeArea(
        bottom: false,
        child: Consumer<FavouritesViewModel>(builder: (_, viewModel, __) {
          if (viewModel.isLoading) {
            return CupertinoActivityIndicator();
          } else if (viewModel.favouriteMovies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.heart_slash,
                      size: 60, color: CupertinoColors.systemGrey),
                  SizedBox(height: 10),
                  Text(
                    "No favourite movies yet",
                    style: TextStyle(
                        color: CupertinoColors.systemGrey, fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Add movies to favourites to see them here.",
                    style: TextStyle(
                        color: CupertinoColors.systemGrey2, fontSize: 14),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(
              width: screenSize.width,
              child: PageView.builder(
                  controller: viewModel.pageController,
                  itemCount: viewModel.favouriteMovies.length,
                  itemBuilder: (conext, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FavouriteMovieCell(
                          key: ValueKey(viewModel.favouriteMovies[index].id),
                          index: index,
                          movie: viewModel.favouriteMovies[index],
                          page: viewModel.page),
                    );
                  }),
            );
          }
        }),
      ),
    );
  }
}
