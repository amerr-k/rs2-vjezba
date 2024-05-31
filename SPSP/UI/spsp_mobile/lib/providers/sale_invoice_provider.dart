import 'package:spsp_mobile/models/sale_invoice/sale_invoice.dart';
import 'package:spsp_mobile/providers/base_provider.dart';

class SaleInvoiceProvider extends BaseProvider<SaleInvoice> {
  SaleInvoiceProvider() : super("SaleInvoice");

  @override
  SaleInvoice fromJson(data) {
    return SaleInvoice.fromJson(data);
  }
}
