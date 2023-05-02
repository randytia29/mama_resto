import 'package:equatable/equatable.dart';

import 'category.dart';
import 'customer_review.dart';
import 'menus.dart';

class Restaurant extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? city;
  final String? address;
  final String? pictureId;
  final List<Category>? categories;
  final Menus? menus;
  final double? rating;
  final List<CustomerReview>? customerReviews;

  const Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(json["customerReviews"]!
                .map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "menus": menus?.toJson(),
        "rating": rating,
        "customerReviews": customerReviews == null
            ? []
            : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        city,
        address,
        pictureId,
        categories,
        menus,
        rating,
        customerReviews
      ];
}
