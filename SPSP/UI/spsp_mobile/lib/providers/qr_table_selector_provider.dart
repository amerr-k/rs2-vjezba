import 'package:flutter/widgets.dart';
import 'package:spsp_mobile/models/qr_table.dart';

class QRTableSelectorProvider with ChangeNotifier {
  late QRTable? selectedQRTable = null;
  late DateTime? reservationDate = null;

  setSelectedQRTable(QRTable? newQRTable) {
    selectedQRTable = newQRTable;
    notifyListeners();
  }

  setReservationDate(DateTime? reservationDateString) {
    reservationDate = reservationDateString;
    selectedQRTable = null;
    notifyListeners();
  }
}
