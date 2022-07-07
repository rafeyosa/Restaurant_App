import 'package:equatable/equatable.dart';

import 'category.dart';
import 'customer_review.dart';
import 'menu.dart';

class RestaurantDetail extends Equatable {
  const RestaurantDetail(
      {required this.id,
      required this.name,
      required this.description,
      required this.city,
      required this.address,
      required this.pictureId,
      required this.categories,
      required this.menus,
      required this.rating,
      required this.customerReviews});

  final String id;
  final String? name;
  final String? description;
  final String? city;
  final String? address;
  final String? pictureId;
  final List<Category>? categories;
  final Menu? menus;
  final num? rating;
  final List<CustomerReview>? customerReviews;

  static const empty = RestaurantDetail(
    id: '',
    name: '',
    description: '',
    city: '',
    address: '',
    pictureId: '',
    categories: [],
    menus: null,
    rating: 0,
    customerReviews: [],
  );

  bool get isEmpty => this == RestaurantDetail.empty;

  bool get isNotEmpty => this != RestaurantDetail.empty;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        city: json['city'],
        address: json['address'],
        pictureId: json['pictureId'],
        categories: List<Category>.from(
            (json['categories'] as List).map((x) => Category.fromJson(x))),
        menus: Menu.fromJson(json['menus']),
        rating: json['rating'],
        customerReviews: List<CustomerReview>.from(
            (json['customerReviews'] as List)
                .map((x) => CustomerReview.fromJson(x))),
      );

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
