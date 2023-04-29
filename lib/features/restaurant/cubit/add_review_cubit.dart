import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mama_resto/features/restaurant/domain/entities/customer_review.dart';

import '../domain/repositories/restaurant_repository.dart';

part 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  final RestaurantRepository repository;

  AddReviewCubit({
    required RestaurantRepository restaurantRepository,
  })  : repository = restaurantRepository,
        super(AddReviewInitial());

  void sendReview(String id, String name, String review) async {
    emit(AddReviewLoading());

    final result = await repository.addReview(id, name, review);

    result.fold((l) => emit(AddReviewFailed(message: l)),
        (r) => emit(AddReviewSuccess(reviews: r)));
  }
}
