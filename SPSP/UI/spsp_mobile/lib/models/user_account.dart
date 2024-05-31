import 'package:json_annotation/json_annotation.dart';

part 'user_account.g.dart';

@JsonSerializable()
class UserAccount {
  int id;
  String username;
  String email;
  String? password;
  String firstName;
  String lastName;
  bool valid;

  UserAccount(this.id, this.username, this.email, this.password, this.firstName,
      this.lastName, this.valid);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UserAccount.fromJson(Map<String, dynamic> json) => _$UserAccountFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
}
