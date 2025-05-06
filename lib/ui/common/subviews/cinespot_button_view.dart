import 'package:flutter/cupertino.dart';

class CinespotButtonView extends StatelessWidget {
  final VoidCallback onTab;
  final String title;
  final bool enabled;

  const CinespotButtonView(
      {super.key,
      required this.onTab,
      required this.enabled,
      required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTab : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
              color: enabled
                  ? CupertinoColors.systemYellow
                  : CupertinoColors.inactiveGray),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: enabled
                  ? CupertinoColors.systemYellow
                  : CupertinoColors.inactiveGray,
              fontSize: 14),
        ),
      ),
    );
  }
}
