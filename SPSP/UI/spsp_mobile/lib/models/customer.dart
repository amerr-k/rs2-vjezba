import 'package:json_annotation/json_annotation.dart';
import 'package:spsp_mobile/models/user_account.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  int id;
  int? userAccountId;
  UserAccount? userAccount;
  String? address;
  String? phone;
  int? penaltyPoints;
  bool? valid;

  Customer(this.id, this.userAccountId, this.userAccount, this.address, this.phone,
      this.penaltyPoints, this.valid);

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
