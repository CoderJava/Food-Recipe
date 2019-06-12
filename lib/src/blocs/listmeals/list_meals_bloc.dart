import 'package:food_recipe/src/models/filtercategories/filter_categories.dart';
import 'package:food_recipe/src/resources/repository.dart';

class ListMealsBloc {
  final _repository = Repository();

  Future<FilterCategories> getFilterCategories(String category) async {
    return await _repository.getFilterByCategories(category);
  }

  dispose() {
    // TODO: do something in here
  }

}

final listMealsBloc = ListMealsBloc();