import 'package:food_recipe/src/models/searchmeals/search_meals.dart';
import 'package:food_recipe/src/resources/food_api_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchMealsBloc {
  final _repository = FoodApiRepository();
  final _publishSubjectSearchMealsByKeyword = PublishSubject<SearchMeals>();

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
          await _repository.getSearchMealsByKeyword(keyword);
      _publishSubjectSearchMealsByKeyword.sink.add(searchMeals);
    }
  }
}

final searchMealsBloc = SearchMealsBloc();
