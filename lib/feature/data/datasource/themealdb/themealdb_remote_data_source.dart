import 'package:dio/dio.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';
import 'package:food_recipe/feature/data/model/searchmealbyname/search_meal_by_name_response.dart';

abstract class TheMealDbRemoteDataSource {
  Future<DetailMealResponse> getRandomMeal();

  Future<MealCategoryResponse> getCategoryMeal();

  Future<FilterByCategoryResponse> getFilterByCategory(String category);

  Future<SearchMealByNameResponse> searchMealByName(String name);

  Future<DetailMealResponse> getDetailMealById(String id);
}

class TheMealDbRemoteDataSourceImpl implements TheMealDbRemoteDataSource {
  final Dio dio;

  TheMealDbRemoteDataSourceImpl({this.dio});

  @override
  Future<DetailMealResponse> getRandomMeal() async {
    var response = await dio.get(
      '/random.php',
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      var detailMealResponse = convertJsonToDetailMealResponse(responseData);
      return detailMealResponse;
    } else {
      throw DioError();
    }
  }

  DetailMealResponse convertJsonToDetailMealResponse(Map<String, dynamic> responseData) {
    var index = 1;
    var listIngredients = <String>[];
    List responseMeals = responseData['meals'];
    responseMeals[0].forEach((key, value) {
      if (key.contains('strIngredient') && value.toString().isNotEmpty) {
        var ingredient = value;
        var measure = responseMeals[0]['strMeasure$index'];
        listIngredients.add('$ingredient $measure');
        index++;
      }
    });
    return DetailMealResponse(
      idMeal: responseMeals[0]['idMeal'],
      strMeal: responseMeals[0]['strMeal'],
      strCategory: responseMeals[0]['strCategory'],
      strArea: responseMeals[0]['strArea'],
      strInstructions: responseMeals[0]['strInstructions'],
      strMealThumb: responseMeals[0]['strMealThumb'],
      strTags: responseMeals[0]['strTags'],
      strYoutube: responseMeals[0]['strYoutube'],
      strSource: responseMeals[0]['strSource'],
      listIngredients: listIngredients,
    );
  }

  @override
  Future<MealCategoryResponse> getCategoryMeal() async {
    var response = await dio.get(
      '/categories.php',
    );
    if (response.statusCode == 200) {
      return MealCategoryResponse.fromJson(response.data);
    } else {
      throw DioError();
    }
  }

  @override
  Future<FilterByCategoryResponse> getFilterByCategory(String category) async {
    var response = await dio.get(
      '/filter.php',
      queryParameters: {
        'c': category,
      },
    );
    if (response.statusCode == 200) {
      return FilterByCategoryResponse.fromJson(response.data);
    } else {
      throw DioError();
    }
  }

  @override
  Future<SearchMealByNameResponse> searchMealByName(String name) async {
    var response = await dio.get(
      '/search.php',
      queryParameters: {
        's': name,
      },
    );
    if (response.statusCode == 200) {
      return SearchMealByNameResponse.fromJson(response.data);
    } else {
      throw DioError();
    }
  }

  @override
  Future<DetailMealResponse> getDetailMealById(String id) async {
    var response = await dio.get(
      '/lookup.php',
      queryParameters: {
        'i': id,
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      var detailMealResponse = convertJsonToDetailMealResponse(responseData);
      return detailMealResponse;
    } else {
      throw DioError();
    }
  }
}
