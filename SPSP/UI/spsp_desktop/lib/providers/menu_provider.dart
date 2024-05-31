import 'package:spsp_desktop/models/menu/menu.dart';
import 'package:spsp_desktop/providers/base_provider.dart';

class MenuProvider extends BaseProvider<Menu> {
  MenuProvider() : super("Menu");

  @override
  Menu fromJson(data) {
    return Menu.fromJson(data);
  }
}
