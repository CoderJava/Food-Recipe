import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/core/network/network_info.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('ConnectionChecker', () {
    test(
      'pastikan fungsi DataConnectionChecker.hasConnection benar-benar terpanggil dan koneksi internetnya terhubung',
      () async {
        // arrange
        final tHasConnection = Future.value(true);
        when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => tHasConnection);

        // act
        final result = networkInfoImpl.isConnected;

        // assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnection);
      },
    );

    test(
      'pastikan fungsi DataConnectionChecker.hasConnection benar-benr terpanggil dan koneksi internetnya '
          'tidak terhbung',
      () async {
        // arrange
        final tHasConnection = Future.value(false);
        when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => tHasConnection);

        // act
        final result = networkInfoImpl.isConnected;

        // assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnection);
      },
    );
  });
}