enum ReservationStatus {
  PENDING_CONFIRMATION,
  ON_HOLD,
  CONFIRMED,
  CANCELED,
}

extension ReservationStatusExtension on ReservationStatus {
  String get value {
    switch (this) {
      case ReservationStatus.PENDING_CONFIRMATION:
        return 'Na čekanju potvrde';
      case ReservationStatus.ON_HOLD:
        return 'Na čekanju';
      case ReservationStatus.CONFIRMED:
        return 'Potvrđeno';
      case ReservationStatus.CANCELED:
        return 'Otkazano';
    }
  }
}
