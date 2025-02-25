import 'package:flutter/cupertino.dart';

class SizedActivityIndicator extends StatelessWidget {
  final double? width;
  final double? height;

  const SizedActivityIndicator({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CupertinoActivityIndicator(),
    );
  }
}
