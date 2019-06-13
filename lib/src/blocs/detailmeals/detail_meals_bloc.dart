import 'package:food_recipe/src/models/lookupmealsbyid/lookup_meals_by_id.dart';
import 'package:food_recipe/src/resources/food_api_repository.dart';

class DetailsMealsBloc {
  final _foodApiRepository = FoodApiRepository();

  dispose() {
    // TODO: do something in here
  }

  Future<LookupMealsById> getDetailsMealsById(String idMeal) async {
    return await _foodApiRepository.getLookupMealsById(idMeal);
  }

}

final detailsMealsBloc = DetailsMealsBloc();