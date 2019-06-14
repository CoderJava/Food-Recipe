import 'package:food_recipe/src/database/entity/favorite_meal.dart';
import 'package:food_recipe/src/database/repository/favorite_meal_repository.dart';
import 'package:food_recipe/src/models/lookupmealsbyid/lookup_meals_by_id.dart';
import 'package:food_recipe/src/models/searchmeals/search_meals.dart';
import 'package:food_recipe/src/resources/food_api_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchMealsBloc {
  final _publishSubjectSearchMealsByKeyword = PublishSubject<SearchMeals>();
  final _foodApiRepository = FoodApiRepository();
  final _favoriteMealRepository = FavoriteMealRepository();

  dispose() {
    _publishSubjectSearchMealsByKeyword.close();
  }

  Observable<SearchMeals> get resultSearchMealsByKeyword =>
      _publishSubjectSearchMealsByKeyword.stream;

  searchMealsByKeyword(String keyword) async {
    _publishSubjectSearchMealsByKeyword.sink.add(SearchMeals(isLoading: true));
    if (keyword.trim().isEmpty) {
      _publishSubjectSearchMealsByKeyword.sink
          .add(SearchMeals(searchMealsItems: []));
    } else {
      SearchMeals searchMeals =
          await _foodApiRepository.getSearchMealsByKeyword(keyword);
      List<FavoriteMeal> listFavoriteMeals =
          await _favoriteMealRepository.getAllFavoriteMeals();
      if (searchMeals.searchMealsItems == null) {
        _publishSubjectSearchMealsByKeyword.sink.add(SearchMeals(searchMealsItems: []));
        return;
      }
      List<SearchMealsItem> listSearchMealsItem =
          searchMeals.searchMealsItems.where((searchMealsItem) {
        for (FavoriteMeal favoriteMeal in listFavoriteMeals) {
          if (favoriteMeal.idMeal == searchMealsItem.idMeal) {
            searchMealsItem.isFavorite = true;
            break;
          }
        }
        return true;
      }).toList();
      searchMeals.searchMealsItems = listSearchMealsItem;
      _publishSubjectSearchMealsByKeyword.sink.add(searchMeals);
    }
  }

  Future<LookupMealsById> getDetailMealById(String id) async {
    LookupMealsById lookupMealsById =
        await _foodApiRepository.getLookupMealsById(id);
    return lookupMealsById;
  }

  Future<int> addFavoriteMeal(FavoriteMeal favoriteMeal) async {
    return await _favoriteMealRepository.insertFavoriteMeal(favoriteMeal);
  }

  Future<int> deleteFavoriteMealById(String id) async {
    return await _favoriteMealRepository.deleteFavoriteMealById(id);
  }
}
