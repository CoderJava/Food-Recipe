import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:meta/meta.dart';
import 'package:food_recipe/feature/domain/usecase/searchmealbyname/search_meal_by_name.dart';
import './bloc.dart';

class SearchMealBloc extends Bloc<SearchMealEvent, SearchMealState> {
  final SearchMealByName searchMealByName;

  SearchMealBloc({@required this.searchMealByName}) : assert(searchMealByName != null);

  @override
  SearchMealState get initialState => InitialSearchMealState();

  @override
  Stream<SearchMealState> mapEventToState(
    SearchMealEvent event,
  ) async* {
    if (event is LoadSearchMealEvent) {
      yield* _mapLoadSearchMealEventToState(event);
    }
  }

  Stream<SearchMealState> _mapLoadSearchMealEventToState(LoadSearchMealEvent event) async* {
    yield LoadingSearchMealState();
    var result = await searchMealByName(ParamsSearchMealByName(name: event.name));
    yield result.fold(
      // ignore: missing_return
      (failure) {
        if (failure is ServerFailure) {
          return FailureSearchMealState(failure.errorMessage);
        } else if (failure is ConnectionFailure) {
          return FailureSearchMealState(failure.errorMessage);
        }
      },
      (response) => LoadedSearchMealState(response),
    );
  }
}
