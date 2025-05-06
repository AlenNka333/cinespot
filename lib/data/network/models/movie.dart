import 'package:cinespot/utils/constants.dart';
import 'package:cinespot/utils/extensions/list_extension.dart';
import 'package:cinespot/data/network/models/company.dart';
import 'package:cinespot/data/network/models/genre.dart';
import 'package:cinespot/data/network/models/language.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey()
  final int id;
  @JsonKey()
  final String title;
  @JsonKey()
  final String overview;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "poster_path", fromJson: _fromJsonUrl)
  final String posterUrl;
  @JsonKey(name: "backdrop_path", fromJson: _fromJsonUrl)
  final String backdropUrl;
  @JsonKey()
  final bool? adult;
  @JsonKey()
  final List<Genre>? genres;
  @JsonKey(name: "production_companies")
  final List<Company>? companies;
  @JsonKey(name: "release_date")
  final String? releaseDate;
  @JsonKey()
  final String? tagline;
  @JsonKey(name: "spoken_languages")
  final List<Language>? languages;

  Movie(
      this.id,
      this.title,
      this.overview,
      this.voteAverage,
      this.posterUrl,
      this.backdropUrl,
      this.adult,
      this.genres,
      this.companies,
      this.releaseDate,
      this.tagline,
      this.languages);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  static List<Movie> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String _fromJsonUrl(String? url) {
    return url == null ? "" : AppConstants.posterPath + url;
  }
}

enum ProductionType { companies, countries }

enum MovieCategory {
  upcoming,
  topRated,
  nowPlaying,
  popular;
}

extension MovieCategoryExtension on MovieCategory {
  String get rawValue {
    switch (this) {
      case MovieCategory.topRated:
        return "top_rated";
      case MovieCategory.nowPlaying:
        return "now_playing";
      default:
        return name;
    }
  }

  String get title {
    switch (this) {
      case MovieCategory.topRated:
        return "Top Rated".toUpperCase();
      case MovieCategory.nowPlaying:
        return "Now Playing".toUpperCase();
      default:
        return name.toUpperCase();
    }
  }

  String get description {
    switch (this) {
      case MovieCategory.upcoming:
        return "New releases for you";
      case MovieCategory.topRated:
        return "Critically acclaimed films that everyone is talking about";
      case MovieCategory.nowPlaying:
        return "Catch the latest blockbusters in theaters right now";
      case MovieCategory.popular:
        return "Most-watched movies of the moment — join the trend";
    }
  }
}

extension CustomOutput on Movie {
  String movieReleaseDescription() {
    return "${this.genres?.joinByName() ?? ""}•${this.releaseDate ?? ""}${this.adult ?? true ? "•18+" : ""}";
  }

  String moviePopularityDescription() {
    return "🌐${this.languages.joinByIndex()}  ★ ${this.voteAverage}";
  }
}
