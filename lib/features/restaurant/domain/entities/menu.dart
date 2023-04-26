import 'package:equatable/equatable.dart';

import 'meal.dart';

class Menu extends Equatable {
  const Menu({
    this.foods,
    this.drinks,
  });

  final List<Meal>? foods;
  final List<Meal>? drinks;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: json["foods"] == null
            ? []
            : List<Meal>.from(json["foods"]!.map((x) => Meal.fromJson(x))),
        drinks: json["drinks"] == null
            ? []
            : List<Meal>.from(json["drinks"]!.map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": foods == null
            ? []
            : List<dynamic>.from(foods!.map((x) => x.toJson())),
        "drinks": drinks == null
            ? []
            : List<dynamic>.from(drinks!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [foods, drinks];
}
