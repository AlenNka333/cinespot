import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey()
  final String username;
  @JsonKey(name: "id")
  final int accountId;

  User({required this.username, required this.accountId});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
