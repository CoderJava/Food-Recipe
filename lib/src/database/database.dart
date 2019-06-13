import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final favoriteTable = "favorite";

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "FoodRecipe.db");

    var database = await openDatabase(
        path, version: 1, onCreate: initDb, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {
      // TODO: do something in here if needed to upgrade database version
    }
  }

  void initDb(Database database, int version) async {
    String queryCreateTableFavorite = "CREATE TABLE $favoriteTable ("
        "idMeal TEXT PRIMARY KEY, "
        "strMeal TEXT, "
        "strMealThumb TEXT, "
        "strCategory TEXT, "
        "strTags TEXT, "
        "strYoutube TEXT, "
        "strArea TEXT, "
        "strInstructions TEXT, "
        "strIngredient1 TEXT, "
        "strIngredient2 TEXT, "
        "strIngredient3 TEXT, "
        "strIngredient4 TEXT, "
        "strIngredient5 TEXT, "
        "strIngredient6 TEXT, "
        "strIngredient7 TEXT, "
        "strIngredient8 TEXT, "
        "strIngredient9 TEXT, "
        "strIngredient10 TEXT, "
        "strIngredient11 TEXT, "
        "strIngredient12 TEXT, "
        "strIngredient13 TEXT, "
        "strIngredient14 TEXT, "
        "strIngredient15 TEXT, "
        "strIngredient16 TEXT, "
        "strIngredient17 TEXT, "
        "strIngredient18 TEXT, "
        "strIngredient19 TEXT, "
        "strIngredient20 TEXT, "
        "strMeasure1 TEXT, "
        "strMeasure2 TEXT, "
        "strMeasure3 TEXT, "
        "strMeasure4 TEXT, "
        "strMeasure5 TEXT, "
        "strMeasure6 TEXT, "
        "strMeasure7 TEXT, "
        "strMeasure8 TEXT, "
        "strMeasure9 TEXT, "
        "strMeasure10 TEXT, "
        "strMeasure11 TEXT, "
        "strMeasure12 TEXT, "
        "strMeasure13 TEXT, "
        "strMeasure14 TEXT, "
        "strMeasure15 TEXT, "
        "strMeasure16 TEXT, "
        "strMeasure17 TEXT, "
        "strMeasure18 TEXT, "
        "strMeasure19 TEXT, "
        "strMeasure20 TEXT "
        ")";
    await database.execute(queryCreateTableFavorite);
  }
}
