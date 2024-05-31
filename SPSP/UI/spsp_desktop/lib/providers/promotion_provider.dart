import 'package:spsp_desktop/models/promotion/promotion.dart';
import 'package:spsp_desktop/providers/base_provider.dart';

class PromotionProvider extends BaseProvider<Promotion> {
  PromotionProvider() : super("Promotion");

  @override
  Promotion fromJson(data) {
    return Promotion.fromJson(data);
  }
}
