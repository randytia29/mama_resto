import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mama_resto/features/restaurant/cubit/restaurant_cubit.dart';
import 'package:mama_resto/features/restaurant/domain/entities/get_list_restaurant_params.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:mama_resto/features/restaurant/domain/usecases/get_list_restaurant.dart';
import 'package:mockito/mockito.dart';

class MockGetListRestaurant extends Mock implements GetListRestaurant {}

void main() {
  MockGetListRestaurant mockGetListRestaurant;
  RestaurantCubit restaurantCubit;

  mockGetListRestaurant = MockGetListRestaurant();
  restaurantCubit = RestaurantCubit(listRestaurant: mockGetListRestaurant);
  setUp(() {});

  tearDown(() => restaurantCubit.close());

  test('bloc should have initial state as [RestaurantInitial]',
      () => expect(restaurantCubit.state.runtimeType, RestaurantInitial));

  blocTest(
    'should emit [RestaurantLoading, RestaurantLoaded] state when data loaded',
    build: () => restaurantCubit,
    act: (cubit) {
      when(mockGetListRestaurant.call(const GetListRestaurantParams(query: '')))
          .thenAnswer((_) async => const Right([]));

      cubit.fetchRestaurant(query: '');
    },
    expect: () => [isA<RestaurantLoading>(), isA<RestaurantLoaded>()],
  );
}
