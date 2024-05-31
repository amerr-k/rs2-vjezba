import 'package:spsp_mobile/models/promotion.dart';
import 'package:spsp_mobile/providers/base_provider.dart';

class PromotionProvider extends BaseProvider<Promotion> {
  PromotionProvider() : super("Promotion");

  @override
  Promotion fromJson(data) {
    return Promotion.fromJson(data);
  }
}
