import 'package:food_recipe/src/models/lookupmealsbyid/lookup_meals_by_id.dart';
import 'package:food_recipe/src/resources/repository.dart';

class DetailsMealsBloc {
  final _repository = Repository();

  dispose() {
    // TODO: do something in here
  }

  Future<LookupMealsById> getDetailsMealsById(String idMeal) async {
    return await _repository.getLookupMealsById(idMeal);
  }

}

final detailsMealsBloc = DetailsMealsBloc();