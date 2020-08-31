import 'package:dio/dio.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';

abstract class TheMealDbRemoteDataSource {
  Future<DetailMealResponse> getRandomMeal();
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
}
