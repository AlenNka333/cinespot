import 'package:cinespot/ui/root/favourites/subviews/movie_cell/favourite_movie_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/root/favourites/bloc/favourites_bloc.dart';

class FavouritesViewController extends StatefulWidget {
  const FavouritesViewController({super.key});

  @override
  State<FavouritesViewController> createState() =>
      _FavouritesViewControllerState();
}

class _FavouritesViewControllerState extends State<FavouritesViewController> {
  late final PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    _pageController.addListener(_onScroll);

    context.read<FavouritesBloc>().add(LoadFavourites());
  }

  void _onScroll() {
    setState(() {
      _currentPage = _pageController.page ?? 0.0;
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            if (state is FavouritesLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is FavouritesEmpty) {
              return _emptyMoviesView();
            } else if (state is FavouritesLoaded) {
              return _moviesPageView(state.movies);
            } else if (state is FetchingFavouritesFailed) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _emptyMoviesView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(CupertinoIcons.heart_slash,
              size: 60, color: CupertinoColors.systemGrey),
          SizedBox(height: 10),
          Text("No favourite movies yet",
              style:
                  TextStyle(color: CupertinoColors.systemGrey, fontSize: 18)),
          SizedBox(height: 5),
          Text("Add movies to favourites to see them here.",
              style:
                  TextStyle(color: CupertinoColors.systemGrey2, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _moviesPageView(List<Movie> movies) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: screenSize.width,
      child: PageView.builder(
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FavouriteMovieCell(
              key: ValueKey(movies[index].id),
              index: index,
              movie: movies[index],
              page: _currentPage,
            ),
          );
        },
      ),
    );
  }
}
