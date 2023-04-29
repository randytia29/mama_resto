import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mama_resto/features/restaurant/domain/entities/customer_review.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewState.initial());

  void setReviews(List<CustomerReview> reviews) =>
      emit(state.copyWith(reviews: reviews));
}
