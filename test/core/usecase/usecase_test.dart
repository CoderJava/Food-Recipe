import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/core/usecase/usecase.dart';

void main() {
  test(
    'pastikan nilai props dari class NoParams adalah []',
    () async {
      // assert
      expect(NoParams().props, []);
    },
  );
}