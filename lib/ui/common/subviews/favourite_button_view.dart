import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteButtonView extends StatelessWidget {
  final VoidCallback onPressed;
  bool isSelected;

  FavouriteButtonView(
      {super.key, required this.onPressed, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(CupertinoIcons.heart),
      isSelected: isSelected,
      selectedIcon: Icon(CupertinoIcons.heart_fill),
      color: Colors.red,
    );
  }
}
