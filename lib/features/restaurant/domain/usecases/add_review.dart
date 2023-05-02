import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mama_resto/core/usecases/usecase.dart';
import 'package:mama_resto/features/restaurant/domain/entities/customer_review.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';

class AddReview implements Usecase<List<CustomerReview>, Params> {
  final RestaurantRepository repository;

  AddReview(this.repository);

  @override
  Future<Either<String, List<CustomerReview>>> call(Params params) async =>
      await repository.addReview(params.id, params.name, params.review);
}

class Params extends Equatable {
  final String id;
  final String name;
  final String review;

  const Params({required this.id, required this.name, required this.review});

  @override
  List<Object?> get props => [id, name, review];
}
