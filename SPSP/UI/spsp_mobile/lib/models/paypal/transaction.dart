import 'package:json_annotation/json_annotation.dart';
import 'package:spsp_mobile/models/paypal/amount.dart';
import 'package:spsp_mobile/models/paypal/item_list.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  Amount amount;
  String? description;
  ItemList itemList;

  Transaction(this.amount, this.itemList, {this.description});

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
