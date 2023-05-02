import 'package:equatable/equatable.dart';

class GetDetailRestaurantParams extends Equatable {
  final String id;

  const GetDetailRestaurantParams({required this.id});

  @override
  List<Object?> get props => [id];
}
