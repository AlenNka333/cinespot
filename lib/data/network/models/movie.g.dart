// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['overview'] as String,
      (json['vote_average'] as num).toDouble(),
      Movie._fromJsonUrl(json['poster_path'] as String?),
      Movie._fromJsonUrl(json['backdrop_path'] as String?),
      json['adult'] as bool?,
      (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['production_companies'] as List<dynamic>?)
          ?.map((e) => Company.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['release_date'] as String?,
      json['tagline'] as String?,
      (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'vote_average': instance.voteAverage,
      'poster_path': instance.posterUrl,
      'backdrop_path': instance.backdropUrl,
      'adult': instance.adult,
      'genres': instance.genres,
      'production_companies': instance.companies,
      'release_date': instance.releaseDate,
      'tagline': instance.tagline,
      'spoken_languages': instance.languages,
    };
