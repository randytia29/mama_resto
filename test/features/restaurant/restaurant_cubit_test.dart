import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mama_resto/features/restaurant/cubit/restaurant_cubit.dart';
import 'package:mama_resto/features/restaurant/domain/entities/get_list_restaurant_params.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:mama_resto/features/restaurant/domain/usecases/get_list_restaurant.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_cubit_test.mocks.dart';

@GenerateMocks([GetListRestaurant])
void main() {
  late MockGetListRestaurant mockGetListRestaurant;
  late RestaurantCubit restaurantCubit;

  setUp(() {
    mockGetListRestaurant = MockGetListRestaurant();
    restaurantCubit = RestaurantCubit(listRestaurant: mockGetListRestaurant);
  });

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
    verify: (cubit) {
      verify(mockGetListRestaurant
              .call(const GetListRestaurantParams(query: '')))
          .called(1);
    },
  );

  blocTest(
    'should emit [RestaurantLoading, RestaurantFailed] state when data failed',
    build: () => restaurantCubit,
    act: (cubit) {
      when(mockGetListRestaurant.call(const GetListRestaurantParams(query: '')))
          .thenAnswer((_) async => const Left('errorMessage'));

      cubit.fetchRestaurant(query: '');
    },
    expect: () => [isA<RestaurantLoading>(), isA<RestaurantFailed>()],
    verify: (cubit) {
      verify(mockGetListRestaurant
              .call(const GetListRestaurantParams(query: '')))
          .called(1);
    },
  );
}
