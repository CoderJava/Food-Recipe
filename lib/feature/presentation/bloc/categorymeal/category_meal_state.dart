import 'package:equatable/equatable.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';

abstract class CategoryMealState extends Equatable {
  const CategoryMealState();

  @override
  List<Object> get props => [];
}

class InitialCategoryMealState extends CategoryMealState {}

class LoadingCategoryMealState extends CategoryMealState {}

class LoadingDetailCategoryMealState extends CategoryMealState {}

class FailureCategoryMealState extends CategoryMealState {
  final String errorMessage;

  FailureCategoryMealState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureCategoryMealState{errorMessage: $errorMessage}';
  }
}

class FailureDetailCategoryMealState extends CategoryMealState {
  final String errorMessage;

  FailureDetailCategoryMealState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureDetailCategoryMealState{errorMessage: $errorMessage}';
  }
}

class LoadedCategoryMealState extends CategoryMealState {
  final MealCategoryResponse mealCategoryResponse;
  final FilterByCategoryResponse filterByCategoryResponse;

  LoadedCategoryMealState(this.mealCategoryResponse, this.filterByCategoryResponse);

  @override
  List<Object> get props => [mealCategoryResponse, filterByCategoryResponse];

  @override
  String toString() {
    return 'LoadedCategoryMealState{mealCategoryResponse: $mealCategoryResponse, '
        'filterByCategoryResponse: $filterByCategoryResponse}';
  }
}

class LoadedDetailCategoryMealState extends CategoryMealState {
  final FilterByCategoryResponse filterByCategoryResponse;

  LoadedDetailCategoryMealState(this.filterByCategoryResponse);

  @override
  List<Object> get props => [filterByCategoryResponse];

  @override
  String toString() {
    return 'LoadedDetailCategoryMealState{filterByCategoryResponse: $filterByCategoryResponse}';
  }
}