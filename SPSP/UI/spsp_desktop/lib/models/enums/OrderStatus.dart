enum OrderStatus {
  ACTIVE,
  COMPLETED,
  CANCELED,
}

extension OrderStatusExtension on OrderStatus {
  String get value {
    switch (this) {
      case OrderStatus.ACTIVE:
        return 'AKTIVNO';
      case OrderStatus.COMPLETED:
        return 'ZAVRŠENO';
      case OrderStatus.CANCELED:
        return 'OTKAZANO';
    }
  }

  static OrderStatus enumFromString(String value) {
    if (!_stringToEnum.containsKey(value)) {
      throw ArgumentError('Invalid value: $value');
    }
    return _stringToEnum[value]!;
  }
}

final Map<String, OrderStatus> _stringToEnum = {
  'ACTIVE': OrderStatus.ACTIVE,
  'COMPLETED': OrderStatus.COMPLETED,
  'CANCELED': OrderStatus.CANCELED,
};
