import 'dart:async';
import 'package:food_recipe/core/error/failure.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:food_recipe/feature/domain/usecase/getdetailmealbyid/get_detail_meal_by_id.dart';
import './bloc.dart';

class DetailMealBloc extends Bloc<DetailMealEvent, DetailMealState> {
  final GetDetailMealById getDetailMealById;

  DetailMealBloc({@required this.getDetailMealById}) : assert(getDetailMealById != null);

  @override
  DetailMealState get initialState => InitialDetailMealState();

  @override
  Stream<DetailMealState> mapEventToState(
    DetailMealEvent event,
  ) async* {
    if (event is LoadDetailMealEvent) {
      yield* _mapLoadDetailMealEventToState(event);
    }
  }

  Stream<DetailMealState> _mapLoadDetailMealEventToState(LoadDetailMealEvent event) async* {
    yield LoadingDetailMealState();
    var result = await getDetailMealById(ParamsGetDetailMealById(event.idMeal));
    yield result.fold(
      // ignore: missing_return
      (failure) {
        if (failure is ServerFailure) {
          return FailureDetailMealState();
        } else if (failure is ConnectionFailure) {
          return FailureDetailMealState();
        }
      },
      (response) => LoadedDetailMealState(response),
    );
  }
}
