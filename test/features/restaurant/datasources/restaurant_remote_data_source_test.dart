import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mama_resto/features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'package:mama_resto/features/restaurant/data/models/customer_review.dart';
import 'package:mama_resto/features/restaurant/data/models/restaurant.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_remote_data_source_test.mocks.dart';

@GenerateMocks([HttpClientAdapter])
void main() {
  final Dio tdio = Dio();
  late MockHttpClientAdapter mockHttpClientAdapter;
  late RestaurantRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockHttpClientAdapter = MockHttpClientAdapter();
    tdio.httpClientAdapter = mockHttpClientAdapter;
    remoteDataSource = RestaurantRemoteDataSourceImpl(dio: tdio);
  });

  group('Get method', () {
    test('can be used to get responses for any url', () async {
      final responsepayload = jsonEncode({
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      });

      final httpResponse = ResponseBody.fromString(
        responsepayload,
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

      when(mockHttpClientAdapter.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final result = await remoteDataSource.getListRestaurant('');

      result.fold((l) {
        expect(l, 'success');
      }, (r) {
        expect(r, [
          const Restaurant(
              id: 'rqdv5juczeskfw1e867',
              name: 'Melting Pot',
              description:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...',
              pictureId: '14',
              city: 'Medan',
              rating: 4.2,
              address: null,
              categories: [],
              customerReviews: [],
              menus: null)
        ]);
      });
    });
  });

  group('Post method', () {
    test('can be used to get responses for any requests', () async {
      final responsepayload = jsonEncode({
        "error": false,
        "message": "success",
        "customerReviews": [
          {"name": "Budi", "review": "Makanan Enak", "date": "2 Mei 2023"},
        ]
      });

      final httpResponse = ResponseBody.fromString(
        responsepayload,
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

      when(mockHttpClientAdapter.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final result =
          await remoteDataSource.addReview('1', 'Budi', 'Makanan Enak');

      result.fold((l) {
        expect(l, 'success');
      }, (r) {
        expect(r, [
          const CustomerReview(
              date: '2 Mei 2023', name: 'Budi', review: 'Makanan Enak')
        ]);
      });
    });
  });
}
