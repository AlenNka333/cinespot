import 'package:flutter/cupertino.dart';

class CinespotButtonView extends StatelessWidget {
  final VoidCallback onTab;
  final String title;

  const CinespotButtonView(
      {super.key, required this.onTab, required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemYellow),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: const TextStyle(
              color: CupertinoColors.systemYellow, fontSize: 14),
        ),
      ),
    );
  }
}
