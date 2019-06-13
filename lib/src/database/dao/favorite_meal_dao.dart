import 'package:food_recipe/src/database/entity/favorite_meal.dart';

import '../database.dart';

class FavoriteMealDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createFavoriteMeal(FavoriteMeal favoriteMeal) async {
    final db = await dbProvider.database;
    var result = db.insert(favoriteTable, favoriteMeal.toJson());
    return result;
  }

  Future<List<FavoriteMeal>> getAllFavoriteMeals() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    result = await db.query(favoriteTable);
    List<FavoriteMeal> listFavoriteMeals = result.isNotEmpty
        ? result.map((resultMap) {
            return FavoriteMeal.fromJson(resultMap);
          }).toList()
        : [];
    return listFavoriteMeals;
  }

  Future<List<FavoriteMeal>> getFavoriteMealById(String id) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    result = await db.query(favoriteTable, where: "idMeal = ?", whereArgs: [id]);
    List<FavoriteMeal> listFavoriteMeals = result.isNotEmpty
        ? result.map((resultMap) {
            return FavoriteMeal.fromJson(resultMap);
          }).toList()
        : [];
    return listFavoriteMeals;
  }

  Future<int> deleteFavoriteMeal(String id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(favoriteTable, where: "idMeal = ?", whereArgs: [id]);
    return result;
  }
}
