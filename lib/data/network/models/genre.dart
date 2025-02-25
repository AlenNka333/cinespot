import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genre {
  @JsonKey()
  final int id;
  @JsonKey()
  final String name;

  Genre(this.id, this.name);

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  static List<Genre> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => Genre.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
