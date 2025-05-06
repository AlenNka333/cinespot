import 'package:cinespot/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company {
  @JsonKey()
  final int id;
  @JsonKey()
  final String name;
  @JsonKey(name: "logo_path", fromJson: _fromJsonUrl)
  final String? logoPath;

  Company(this.id, this.name, this.logoPath);

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
  static List<Company> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => Company.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String? _fromJsonUrl(String? url) {
    return url == null ? null : (AppConstants.posterPath + url);
  }
}
