import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/presentation/bloc/categorymeal/bloc.dart';

void main() {
  group('LoadCategoryMealEvent', () {
    final tLoadCategoryMealEvent = LoadCategoryMealEvent();

    test(
      'pastikan nilai props adalah []',
      () async {
        // assert
        expect(tLoadCategoryMealEvent.props, []);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah LoadCategoryMealEvent',
      () async {
        // assert
        expect(tLoadCategoryMealEvent.toString(), 'LoadCategoryMealEvent');
      },
    );
  });

  group('LoadDetailCategoryMealEvent', () {
    final tCategory = 'testCategory';
    final tLoadDetailCategoryMealEvent = LoadDetailCategoryMealEvent(tCategory);

    test(
      'pastikan nilai props adalah [category]',
      () async {
        // assert
        expect(tLoadDetailCategoryMealEvent.props, [tLoadDetailCategoryMealEvent.category]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah LoadDetailCategoryMealEvent{category: testCategory}',
      () async {
        // assert
        expect(
          tLoadDetailCategoryMealEvent.toString(),
          'LoadDetailCategoryMealEvent{category: ${tLoadDetailCategoryMealEvent.category}}',
        );
      },
    );
  });
}
