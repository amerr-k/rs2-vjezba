import 'package:spsp_mobile/models/menu.dart';
import 'package:spsp_mobile/providers/base_provider.dart';

class MenuProvider extends BaseProvider<Menu> {
  MenuProvider() : super("Menu");

  @override
  Menu fromJson(data) {
    return Menu.fromJson(data);
  }
}
