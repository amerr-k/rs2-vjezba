import 'package:spsp_desktop/models/category/category.dart';
import 'package:spsp_desktop/providers/base_provider.dart';

class CategoryProvider extends BaseProvider<Category> {
  CategoryProvider() : super("Category");

  @override
  Category fromJson(data) {
    return Category.fromJson(data);
  }
}
