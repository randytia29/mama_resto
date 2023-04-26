import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  const Meal({
    this.name,
  });

  final String? name;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  @override
  List<Object?> get props => [name];
}
