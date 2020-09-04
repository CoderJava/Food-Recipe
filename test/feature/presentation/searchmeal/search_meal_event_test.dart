import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/presentation/bloc/searchmeal/bloc.dart';

void main() {
  group('LoadSearchMealEvent', () {
    final tLoadSearchMealEvent = LoadSearchMealEvent('testName');

    test(
      'pastikan nilai props adalah [name]',
      () async {
        // assert
        expect(tLoadSearchMealEvent.props, [tLoadSearchMealEvent.name]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah '
      'LoadSearchMealEvent{name: testName}',
      () async {
        // assert
        expect(tLoadSearchMealEvent.toString(), 'LoadSearchMealEvent{name: ${tLoadSearchMealEvent.name}}');
      },
    );
  });
}
