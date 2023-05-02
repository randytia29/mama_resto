import 'package:equatable/equatable.dart';

class GetListRestaurantParams extends Equatable {
  final String query;

  const GetListRestaurantParams({required this.query});

  @override
  List<Object?> get props => [query];
}
