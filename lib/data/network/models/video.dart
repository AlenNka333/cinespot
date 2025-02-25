import 'package:cinespot/core/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  @JsonKey()
  final String site;
  @JsonKey()
  final String key;
  @JsonKey()
  final String type;

  String get videoUrl {
    return (site == "YouTube"
            ? AppConstants.youTubePath
            : AppConstants.vimeoPath) +
        key;
  }

  Video(this.site, this.key, this.type);

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
  static List<Video> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((e) => Video.fromJson(e as Map<String, dynamic>)).where(
      (element) {
        return element.type == "Trailer";
      },
    ).toList();
  }
}
