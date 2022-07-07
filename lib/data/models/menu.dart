import 'package:equatable/equatable.dart';

import 'category.dart';

class Menu extends Equatable {
  const Menu({
    required this.foods,
    required this.drinks
  });

  final List<Category> foods;
  final List<Category> drinks;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    foods: List<Category>.from((json['foods'] as List).map((x) => Category.fromJson(x))),
    drinks: List<Category>.from((json['drinks'] as List).map((x) => Category.fromJson(x))),
  );

  @override
  List<Object?> get props => [foods, drinks];
}
