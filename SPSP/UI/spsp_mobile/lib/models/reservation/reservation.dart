import 'package:json_annotation/json_annotation.dart';
import 'package:spsp_mobile/models/qr_table.dart';

part 'reservation.g.dart';

@JsonSerializable()
class Reservation {
  int? id;
  int? qrTableId;
  QRTable? qrTable;
  int? customerId;
  String? contactInfo;
  String? specialRequest;
  DateTime? startTime;
  DateTime? endTime;
  String? status;
  bool? valid;

  Reservation({
    this.id,
    this.qrTableId,
    this.qrTable,
    this.customerId,
    this.contactInfo,
    this.specialRequest,
    this.startTime,
    this.endTime,
    this.status,
    this.valid,
  });

  /// A necessary factory constructor for creating a new Reservation instance
  /// from a map. Pass the map to the generated `_$ReservationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Reservation.
  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ReservationToJson`.
  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}
