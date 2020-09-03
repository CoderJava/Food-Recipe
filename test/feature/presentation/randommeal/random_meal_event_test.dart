import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/presentation/bloc/randommeal/random_meal_event.dart';

void main() {
  group('LoadRandomMealEvent', () {
    final tLoadRandomMealEvent = LoadRandomMealEvent();

    test(
      'pastikan nilai props adalah []',
      () async {
        // assert
        expect(tLoadRandomMealEvent.props, []);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah LoadRandomMealEvent',
      () async {
        // assert
        expect(tLoadRandomMealEvent.toString(), 'LoadRandomMealEvent');
      },
    );
  });
}
