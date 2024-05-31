// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRTable _$QRTableFromJson(Map<String, dynamic> json) => QRTable(
      json['id'] as int?,
      json['qrCode'] as String?,
      json['tableNumber'] as int?,
      json['valid'] as bool?,
      json['capacity'] as int?,
      json['locationDescription'] as String,
      json['isReserved'] as bool?,
      json['isTaken'] as bool,
    );

Map<String, dynamic> _$QRTableToJson(QRTable instance) => <String, dynamic>{
      'id': instance.id,
      'qrCode': instance.qrCode,
      'tableNumber': instance.tableNumber,
      'capacity': instance.capacity,
      'locationDescription': instance.locationDescription,
      'isTaken': instance.isTaken,
      'isReserved': instance.isReserved,
      'valid': instance.valid,
    };
