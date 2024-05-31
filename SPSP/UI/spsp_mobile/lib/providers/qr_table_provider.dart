import 'dart:convert';

import 'package:spsp_mobile/models/qr_table.dart';
import 'package:spsp_mobile/models/search_result.dart';
import 'package:spsp_mobile/providers/base_provider.dart';

class QRTableProvider extends BaseProvider<QRTable> {
  QRTableProvider() : super("QRTable");

  @override
  QRTable fromJson(data) {
    return QRTable.fromJson(data);
  }

  Future<RequestResult<QRTable>> getAllByReservationDate({dynamic filter}) async {
    var url = "${BaseProvider.baseUrl}$endpoint/GetAllByReservationDate";
    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var jsonData = jsonDecode(response.body);

      var searchResult = RequestResult<QRTable>();

      for (var item in jsonData) {
        searchResult.result.add(fromJson(item));
      }

      return searchResult;
    } else {
      throw new Exception("Unknown error");
    }
  }
}
