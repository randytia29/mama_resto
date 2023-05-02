import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mama_resto/core/usecases/usecase.dart';
import 'package:mama_resto/features/restaurant/domain/entities/restaurant.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';

class GetDetailRestaurant implements Usecase<Restaurant, Params> {
  final RestaurantRepository repository;

  GetDetailRestaurant(this.repository);

  @override
  Future<Either<String, Restaurant>> call(Params params) async =>
      await repository.getDetailRestaurant(params.id);
}

class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
