part of 'add_review_cubit.dart';

abstract class AddReviewState extends Equatable {
  const AddReviewState();

  @override
  List<Object> get props => [];
}

class AddReviewInitial extends AddReviewState {}

class AddReviewLoading extends AddReviewState {}

class AddReviewSuccess extends AddReviewState {
  final List<CustomerReview> reviews;

  const AddReviewSuccess({required this.reviews});

  @override
  List<Object> get props => [reviews];
}

class AddReviewFailed extends AddReviewState {
  final String message;

  const AddReviewFailed({required this.message});

  @override
  List<Object> get props => [message];
}
