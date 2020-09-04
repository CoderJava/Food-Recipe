import 'package:equatable/equatable.dart';
import 'package:food_recipe/feature/data/model/searchmealbyname/search_meal_by_name_response.dart';

abstract class SearchMealState extends Equatable {
  const SearchMealState();

  @override
  List<Object> get props => [];
}

class InitialSearchMealState extends SearchMealState {}

class LoadingSearchMealState extends SearchMealState {}

class FailureSearchMealState extends SearchMealState {
  final String errorMessage;

  FailureSearchMealState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureSearchMealState{errorMessage: $errorMessage}';
  }
}

class LoadedSearchMealState extends SearchMealState {
  final SearchMealByNameResponse searchMealByNameResponse;

  LoadedSearchMealState(this.searchMealByNameResponse);

  @override
  List<Object> get props => [searchMealByNameResponse];

  @override
  String toString() {
    return 'LoadedSearchMealState{searchMealByNameResponse: $searchMealByNameResponse}';
  }
}