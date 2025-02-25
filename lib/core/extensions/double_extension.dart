extension HalfRating on double? {
  double halfRating() {
    if (this == null) return 0.0;

    return this! / 2;
  }
}
