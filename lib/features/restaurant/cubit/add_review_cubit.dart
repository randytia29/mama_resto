import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mama_resto/features/restaurant/domain/entities/add_review_params.dart';
import 'package:mama_resto/features/restaurant/domain/usecases/add_review.dart';

import '../data/models/customer_review.dart';

part 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  final AddReview addReview;

  AddReviewCubit({required AddReview review})
      : addReview = review,
        super(AddReviewInitial());

  void sendReview(String id, String name, String review) async {
    emit(AddReviewLoading());

    final result =
        await addReview(AddReviewParams(id: id, name: name, review: review));

    result.fold((l) => emit(AddReviewFailed(message: l)),
        (r) => emit(AddReviewSuccess(reviews: r)));
  }
}
