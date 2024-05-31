import 'package:spsp_desktop/models/qr_table/qr_table.dart';
import 'package:spsp_desktop/providers/base_provider.dart';

class QRTableProvider extends BaseProvider<QRTable> {
  QRTableProvider() : super("QRTable");

  @override
  QRTable fromJson(data) {
    return QRTable.fromJson(data);
  }
}
