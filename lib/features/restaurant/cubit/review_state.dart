part of 'review_cubit.dart';

class ReviewState extends Equatable {
  const ReviewState({required this.reviews});

  final List<CustomerReview> reviews;

  factory ReviewState.initial() {
    return const ReviewState(reviews: []);
  }

  ReviewState copyWith({required List<CustomerReview> reviews}) {
    return ReviewState(reviews: reviews);
  }

  @override
  List<Object> get props => [reviews];
}
