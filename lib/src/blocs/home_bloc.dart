import 'package:food_recipe/src/models/categories/categories.dart';
import 'package:food_recipe/src/models/latest/latest_meals.dart';
import 'package:food_recipe/src/resources/repository.dart';

class HomeBloc {
  final _repository = Repository();

  Future<LatestMeals> getLatestMeals() async {
    return await _repository.getLatestMeals();
  }

  Future<Categories> getCategories() async {
    return await _repository.getCategories();
  }

  dispose() {
    // TODO: do something in here
  }

}

final homeBloc = HomeBloc();