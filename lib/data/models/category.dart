import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({required this.name});

  final String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };

  @override
  List<Object?> get props => [name];
}
