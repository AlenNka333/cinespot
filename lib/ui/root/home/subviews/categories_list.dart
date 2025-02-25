import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/ui/root/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: MovieCategory.values.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Consumer<HomeViewModel>(
              builder: (_, viewModel, __) {
                return CategoriesListItemButtonView(
                  isSelected: index == viewModel.currentCategory.index,
                  content: viewModel.categories[index].title,
                  onPressed: () => viewModel.selectCategory(index: index),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoriesListItemButtonView extends StatelessWidget {
  final bool isSelected;
  final String content;
  final VoidCallback onPressed;
  const CategoriesListItemButtonView(
      {super.key,
      required this.isSelected,
      required this.content,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          foregroundColor: Colors.white,
          backgroundColor: isSelected
              ? Color.fromRGBO(119, 127, 194, 1)
              : Color.fromRGBO(88, 112, 138, 1)),
      child: Text(style: TextStyle(fontWeight: FontWeight.w700), content),
    ));
  }
}
