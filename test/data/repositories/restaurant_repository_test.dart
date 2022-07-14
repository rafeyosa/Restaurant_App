import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/data/repositories/restaurant_repository.dart';

import 'restaurant_repository_test.mocks.dart';

class RestaurantRepositoryTest extends Mock implements RestaurantRepository {}

@GenerateMocks([RestaurantRepositoryTest])
Future<void> main() async {
  late MockRestaurantRepositoryTest repoMock;

  setUpAll(() {
    repoMock = MockRestaurantRepositoryTest();
  });

  group('restaurant repository test', () {
    test('test getRestaurantDetail', () async {
      var detailMock = RestaurantDetail.empty;
      var idMock = 'id';

      when(repoMock.getRestaurantDetail(idMock)).thenAnswer((_) async {
        return detailMock;
      });

      final result = await repoMock.getRestaurantDetail(idMock);

      expect(result, isA<RestaurantDetail>());
      expect(result, detailMock);
    });

    test('test getRestaurantDetail throws Exception', () {
      var idMock = 'id';

      when(repoMock.getRestaurantDetail(idMock)).thenAnswer((_) async {
        throw Exception();
      });

      final result = repoMock.getRestaurantDetail(idMock);

      expect(result, throwsException);
    });
  });
}