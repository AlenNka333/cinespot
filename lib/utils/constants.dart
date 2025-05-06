import 'package:flutter/cupertino.dart';

class AppConstants {
  static const String baseUrl = "https://api.themoviedb.org/3/";
  static const String apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZGJkOThhMWI4ZGEzYTg2NmM3MzhkOTMxOGU4NzVhMiIsIm5iZiI6MTczODI1MTIxMy4zNywic3ViIjoiNjc5YjliY2QwNGM4ZGMzNDdjZmJlMWNjIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.WXa10mGzcPssGk5d6VoMUPJvjWnu0b8CvDf3jjQB4BQ";
  static const posterPath = "https://image.tmdb.org/t/p/w500";
  static const youTubePath = "https://www.youtube.com/watch?v=";
  static const vimeoPath = "https://vimeo.com/";

  static const CupertinoThemeData appTheme = CupertinoThemeData(
    barBackgroundColor: Color.fromRGBO(29, 32, 43, 1),
    scaffoldBackgroundColor: Color.fromRGBO(29, 32, 43, 1),
  );
}
