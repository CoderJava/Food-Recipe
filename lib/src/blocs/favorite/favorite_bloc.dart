import 'package:food_recipe/src/database/entity/favorite_meal.dart';
import 'package:food_recipe/src/database/repository/favorite_meal_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'favorite_meals_bloc_model.dart';

class FavoriteBloc {
  final _favoriteMealRepository = FavoriteMealRepository();
   var _publishSubjectListFavoriteMeal =
      PublishSubject<FavoriteMealsBlocModel>();

  dispose() {
    _publishSubjectListFavoriteMeal.close();
  }

  Observable<FavoriteMealsBlocModel> get listFavoriteMeal =>
      _publishSubjectListFavoriteMeal.stream;

  getAllFavoriteMeals() async {
    _publishSubjectListFavoriteMeal.sink
        .add(FavoriteMealsBlocModel(isLoading: true));
    List<FavoriteMeal> listFavoriteMeals =
        await _favoriteMealRepository.getAllFavoriteMeals();
    FavoriteMealsBlocModel favoriteMealsBlocModel =
        FavoriteMealsBlocModel(listFavoriteMeals: listFavoriteMeals);
    _publishSubjectListFavoriteMeal.sink.add(favoriteMealsBlocModel);
  }

  removeFavoriteMealById(String id) async {
    _publishSubjectListFavoriteMeal.sink.add(FavoriteMealsBlocModel(isLoading: true));
    await _favoriteMealRepository.deleteFavoriteMealById(id);
    List<FavoriteMeal> listFavoriteMeals =
    await _favoriteMealRepository.getAllFavoriteMeals();
    FavoriteMealsBlocModel favoriteMealsBlocModel =
    FavoriteMealsBlocModel(listFavoriteMeals: listFavoriteMeals);
    _publishSubjectListFavoriteMeal.sink.add(favoriteMealsBlocModel);
  }

}
