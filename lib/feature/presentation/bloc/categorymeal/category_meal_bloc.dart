import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';
import 'package:meta/meta.dart';
import 'package:food_recipe/feature/domain/usecase/getcategorymeal/get_category_meal.dart';
import 'package:food_recipe/feature/domain/usecase/getfilterbycategory/get_filter_by_category.dart';
import './bloc.dart';

class CategoryMealBloc extends Bloc<CategoryMealEvent, CategoryMealState> {
  final GetCategoryMeal getCategoryMeal;
  final GetFilterByCategory getFilterByCategory;

  CategoryMealBloc({
    @required this.getCategoryMeal,
    @required this.getFilterByCategory,
  })  : assert(getCategoryMeal != null),
        assert(getFilterByCategory != null);

  @override
  CategoryMealState get initialState => InitialCategoryMealState();

  @override
  Stream<CategoryMealState> mapEventToState(
    CategoryMealEvent event,
  ) async* {
    if (event is LoadCategoryMealEvent) {
      yield* _mapLoadCategoryMealEventToState(event);
    } else if (event is LoadDetailCategoryMealEvent) {
      yield* _mapLoadDetailCategoryMealEventToState(event);
    }
  }

  Stream<CategoryMealState> _mapLoadCategoryMealEventToState(LoadCategoryMealEvent event) async* {
    yield LoadingCategoryMealState();
    var resultCategoryMeal = await getCategoryMeal(NoParams());
    var resultFoldCategoryMeal = resultCategoryMeal.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldCategoryMeal is ServerFailure) {
      yield FailureCategoryMealState(resultFoldCategoryMeal.errorMessage);
      return;
    } else if (resultFoldCategoryMeal is ConnectionFailure) {
      yield FailureCategoryMealState(resultFoldCategoryMeal.errorMessage);
      return;
    }
    var mealCategoryResponse = resultFoldCategoryMeal as MealCategoryResponse;
    var category = mealCategoryResponse.categories[0].strCategory;
    var resultFilterByCategory = await getFilterByCategory(ParamsGetFilterByCategory(category: category));
    var resultFoldFilterByCategory = resultFilterByCategory.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldFilterByCategory is ServerFailure) {
      yield FailureCategoryMealState(resultFoldFilterByCategory.errorMessage);
      return;
    } else if (resultFoldFilterByCategory is ConnectionFailure) {
      yield FailureCategoryMealState(resultFoldFilterByCategory.errorMessage);
      return;
    }
    var filterByCategoryResponse = resultFoldFilterByCategory as FilterByCategoryResponse;
    yield LoadedCategoryMealState(mealCategoryResponse, filterByCategoryResponse);
  }

  Stream<CategoryMealState> _mapLoadDetailCategoryMealEventToState(LoadDetailCategoryMealEvent event) async* {
    yield LoadingDetailCategoryMealState();
    var resultFilterByCategory = await getFilterByCategory(ParamsGetFilterByCategory(category: event.category));
    yield resultFilterByCategory.fold(
      // ignore: missing_return
      (failure) {
        if (failure is ServerFailure) {
          return FailureDetailCategoryMealState(failure.errorMessage);
        } else if (failure is ConnectionFailure) {
          return FailureDetailCategoryMealState(failure.errorMessage);
        }
      },
      (response) => LoadedDetailCategoryMealState(response),
    );
  }
}
