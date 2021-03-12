import 'package:coding_challenge/core/network/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  MockDataConnectionChecker mockDataConnectionChecker;
  NetworkInfoImpl netWorkInfoImpl;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    netWorkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });
  group('isConected', () {
    test('should forward the call to DataConnectioncheker.hasConnection',
        () async {
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      final result = await netWorkInfoImpl.isConnected;

      verify(mockDataConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
