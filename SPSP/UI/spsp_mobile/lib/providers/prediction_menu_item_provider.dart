import 'dart:convert';

import 'package:spsp_mobile/models/menu_item_prediction.dart';
import 'package:spsp_mobile/models/search_result.dart';
import 'package:spsp_mobile/providers/base_provider.dart';

class MenuItemPredictionProvider extends BaseProvider<MenuItemPrediction> {
  MenuItemPredictionProvider() : super("MenuItemPrediction");

  @override
  MenuItemPrediction fromJson(data) {
    return MenuItemPrediction.fromJson(data);
  }

  Future<RequestResult<MenuItemPrediction>> getByMainMenuItemId(
      String mainMenuItemId) async {
    var url = "${BaseProvider.baseUrl}$endpoint/GetByMainMenuItemId/$mainMenuItemId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var jsonData = jsonDecode(response.body);

      var searchResult = RequestResult<MenuItemPrediction>();

      for (var item in jsonData) {
        searchResult.result.add(fromJson(item));
      }

      return searchResult;
    } else {
      throw new Exception("Unknown error");
    }
  }
}
