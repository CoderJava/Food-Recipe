import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:meta/meta.dart';
import 'package:food_recipe/feature/domain/usecase/getrandommeal/get_random_meal.dart';
import './bloc.dart';

class RandomMealBloc extends Bloc<RandomMealEvent, RandomMealState> {
  final GetRandomMeal getRandomMeal;

  RandomMealBloc({@required this.getRandomMeal}) : assert(getRandomMeal != null);

  @override
  RandomMealState get initialState => InitialRandomMealState();

  @override
  Stream<RandomMealState> mapEventToState(
    RandomMealEvent event,
  ) async* {
    if (event is LoadRandomMealEvent) {
      yield* _mapLoadRandomMealEventToState();
    }
  }

  Stream<RandomMealState> _mapLoadRandomMealEventToState() async* {
    yield LoadingRandomMealState();
    var result = await getRandomMeal(NoParams());
    yield result.fold(
      // ignore: missing_return
      (failure) {
        if (failure is ServerFailure) {
          return FailureRandomMealState(failure.errorMessage);
        } else if (failure is ConnectionFailure) {
          return FailureRandomMealState(failure.errorMessage);
        }
      },
      (response) => LoadedRandomMealState(response),
    );
  }
}
