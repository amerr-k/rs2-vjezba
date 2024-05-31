import 'package:json_annotation/json_annotation.dart';
import 'package:spsp_mobile/models/user_account.dart';

part 'user_auth_info.g.dart';

@JsonSerializable()
class UserAuthInfo {
  UserAccount userAccount;
  String token;

  UserAuthInfo(this.userAccount, this.token);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UserAuthInfo.fromJson(Map<String, dynamic> json) =>
      _$UserAuthInfoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserAuthInfoToJson(this);
}
