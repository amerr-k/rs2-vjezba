import 'package:spsp_desktop/models/menu_item/menu_item.dart';
import 'package:spsp_desktop/providers/base_provider.dart';

class MenuItemProvider extends BaseProvider<MenuItem> {
  MenuItemProvider() : super("MenuItem");

  @override
  MenuItem fromJson(data) {
    return MenuItem.fromJson(data);
  }
}
