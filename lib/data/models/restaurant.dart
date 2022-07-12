import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  final String id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final num? rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    pictureId: json['pictureId'],
    city: json['city'],
    rating: json['rating'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'pictureId': pictureId,
    'city': city,
    'rating': rating,
  };

@override
  List<Object?> get props => [id, name, description, pictureId, city, rating];
}

const String tableRestaurant = 'restaurants';

class RestaurantField {
  static final List<String> values = [
    id, name, description, pictureId, city, rating
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String description = 'description';
  static const String pictureId = 'pictureId';
  static const String city = 'city';
  static const String rating = 'rating';
}
