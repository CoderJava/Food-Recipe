import 'package:food_recipe/src/models/categories/categories.dart';
import 'package:food_recipe/src/models/latest/latest_meals.dart';
import 'package:food_recipe/src/resources/food_api_repository.dart';

class HomeBloc {
  final _repository = FoodApiRepository();

  dispose() {
    // TODO: do something in here
  }

  Future<LatestMeals> getLatestMeals() async {
    return await _repository.getLatestMeals();
  }

  Future<Categories> getCategories() async {
    return await _repository.getCategories();
  }

}

final homeBloc = HomeBloc();