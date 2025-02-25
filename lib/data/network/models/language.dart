import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language {
  final String name;
  @JsonKey(name: "iso_639_1")
  final String index;

  Language(this.name, this.index);

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
  static List<Language> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => Language.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
