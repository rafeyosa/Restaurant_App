import 'package:equatable/equatable.dart';

import 'category.dart';

class Menu extends Equatable {
  const Menu({
    required this.foods,
    required this.drinks,
  });

  final List<Category> foods;
  final List<Category> drinks;

  static const empty = Menu(
    foods: [],
    drinks: [],
  );

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: List<Category>.from(
            (json['foods'] as List).map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            (json['drinks'] as List).map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'foods': List<Category>.from(foods.map((x) => x.toJson())),
        'drinks': List<Category>.from(drinks.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        foods,
        drinks,
      ];
}