import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/core/error/failure.dart';

void main() {
  final tErrorMessage = 'testErrorMessage';

  group('ServerFailure', () {
    final tServerFailure = ServerFailure(tErrorMessage);

    test(
      'pastikan nilai props adalah [errorMessage]',
      () async {
        // assert
        expect(tServerFailure.props, [tErrorMessage]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah '
      'ServerFailure(errorMessage: testErrorMessage}',
      () async {
        // assert
        expect(tServerFailure.toString(), 'ServerFailure{errorMessage: $tErrorMessage}');
      },
    );
  });

  group('ConnectionFailure', () {
    final tConnectionFailure = ConnectionFailure();
    final tErrorMessage = tConnectionFailure.errorMessage;

    test(
      'pastikan nilai props adalah [errorMessage]',
      () async {
        // assert
        expect(tConnectionFailure.props, [tErrorMessage]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah '
      'ConnectionFailure{errorMessage: testErrorMessage}',
      () async {
        // assert
        expect(
          tConnectionFailure.toString(),
          'ConnectionFailure{errorMessage: ${tConnectionFailure.errorMessage}}',
        );
      },
    );
  });
}
