import 'package:food_recipe/src/models/filtercategories/filter_categories.dart';
import 'package:food_recipe/src/resources/repository.dart';

class ListMealsBloc {
  final repository = Repository();

  Future<FilterCategories> getFilterCategories(String category) async {
    return await repository.getFilterByCategories(category);
  }

  dispose() {
    // TODO: do something in here
  }

}

final listMealsBloc = ListMealsBloc();