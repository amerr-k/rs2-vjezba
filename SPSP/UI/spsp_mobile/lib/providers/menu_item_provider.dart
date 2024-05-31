import 'package:spsp_mobile/models/menu_item.dart';
import 'package:spsp_mobile/providers/base_provider.dart';

class MenuItemProvider extends BaseProvider<MenuItem> {
  MenuItemProvider() : super("MenuItem");

  @override
  MenuItem fromJson(data) {
    return MenuItem.fromJson(data);
  }
}
