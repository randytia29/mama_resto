import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetListRestaurant implements Usecase<List<Restaurant>, Params> {
  final RestaurantRepository repository;

  GetListRestaurant(this.repository);

  @override
  Future<Either<String, List<Restaurant>>> call(Params params) async =>
      await repository.getListRestaurant(params.query);
}

class Params extends Equatable {
  final String query;

  const Params({required this.query});

  @override
  List<Object?> get props => [query];
}
