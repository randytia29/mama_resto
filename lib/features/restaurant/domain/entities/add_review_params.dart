import 'package:equatable/equatable.dart';

class AddReviewParams extends Equatable {
  final String id;
  final String name;
  final String review;

  const AddReviewParams(
      {required this.id, required this.name, required this.review});

  @override
  List<Object?> get props => [id, name, review];
}
