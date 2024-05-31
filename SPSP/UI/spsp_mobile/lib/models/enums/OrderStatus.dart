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
}
