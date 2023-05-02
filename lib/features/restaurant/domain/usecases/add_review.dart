import 'package:dartz/dartz.dart';
import 'package:mama_resto/core/usecases/usecase.dart';
import 'package:mama_resto/features/restaurant/domain/entities/add_review_params.dart';
import 'package:mama_resto/features/restaurant/domain/repositories/restaurant_repository.dart';

import '../../data/models/customer_review.dart';

class AddReview implements Usecase<List<CustomerReview>, AddReviewParams> {
  final RestaurantRepository repository;

  AddReview(this.repository);

  @override
  Future<Either<String, List<CustomerReview>>> call(
          AddReviewParams params) async =>
      await repository.addReview(params.id, params.name, params.review);
}
