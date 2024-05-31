import 'package:json_annotation/json_annotation.dart';

part 'qr_table.g.dart';

@JsonSerializable()
class QRTable {
  int? id;
  String? qrCode;
  int? tableNumber;
  int? capacity;
  String locationDescription;
  bool isTaken;
  bool? isReserved;
  bool? valid;

  QRTable(this.id, this.qrCode, this.tableNumber, this.valid, this.capacity,
      this.locationDescription, this.isReserved, this.isTaken);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory QRTable.fromJson(Map<String, dynamic> json) => _$QRTableFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$QRTableToJson(this);
}
