import 'package:food_recipe/src/database/entity/favorite_meal.dart';
import 'package:food_recipe/src/database/repository/favorite_meal_repository.dart';
import 'package:food_recipe/src/models/filtercategories/filter_categories.dart';
import 'package:food_recipe/src/models/lookupmealsbyid/lookup_meals_by_id.dart';
import 'package:food_recipe/src/resources/food_api_repository.dart';

class ListMealsBloc {
  final _foodApiRepository = FoodApiRepository();
  final _favoriteMealRepository = FavoriteMealRepository();

  dispose() {
    // TODO: do something in here
  }

  Future<FilterCategories> getFilterCategories(String category) async {
    FilterCategories filterCategories =
        await _foodApiRepository.getFilterByCategories(category);
    List<FavoriteMeal> listFavoriteMeals =
        await _favoriteMealRepository.getAllFavoriteMeals();
    List<FilterCategoryItem> listFilterCategoryItems =
        filterCategories.filterCategoryItems.where((item) {
      bool isFavorite = false;
      for (FavoriteMeal favoriteMeal in listFavoriteMeals) {
        if (item.idMeal == favoriteMeal.idMeal) {
          isFavorite = true;
          break;
        }
      }
      item.isFavorite = isFavorite;
      return true;
    }).toList();
    filterCategories.filterCategoryItems = listFilterCategoryItems;
    return filterCategories;
  }

  Future<LookupMealsById> getDetailMealById(String id) async {
    LookupMealsById lookupMealsById = await _foodApiRepository.getLookupMealsById(id);
    return lookupMealsById;
  }

  Future<int> addFavoriteMeal(FavoriteMeal favoriteMeal) async {
    return await _favoriteMealRepository.insertFavoriteMeal(favoriteMeal);
  }

  Future<int> deleteFavoriteMealById(String id) async {
    return await _favoriteMealRepository.deleteFavoriteMealById(id);
  }
}

final listMealsBloc = ListMealsBloc();
