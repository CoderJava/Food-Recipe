import 'package:food_recipe/src/database/dao/favorite_meal_dao.dart';
import 'package:food_recipe/src/database/entity/favorite_meal.dart';

class FavoriteMealRepository {
  final _favoriteMealDao = FavoriteMealDao();

  Future<int> insertFavoriteMeal(FavoriteMeal favoriteMeal) =>
      _favoriteMealDao.createFavoriteMeal(favoriteMeal);

  Future<List<FavoriteMeal>> getAllFavoriteMeals() => _favoriteMealDao.getAllFavoriteMeals();

  Future<List<FavoriteMeal>> getFavoriteMealsById(String id) => _favoriteMealDao.getFavoriteMealById(id);

  Future<int> deleteFavoriteMealById(String id) => _favoriteMealDao.deleteFavoriteMeal(id);

}
