import 'package:spsp_mobile/models/category.dart';
import 'package:spsp_mobile/providers/base_provider.dart';

class CategoryProvider extends BaseProvider<Category> {
  CategoryProvider() : super("Category");

  @override
  Category fromJson(data) {
    return Category.fromJson(data);
  }
}
