import 'package:equatable/equatable.dart';

class AddReview extends Equatable {
  const AddReview({
    required this.id,
    required this.name,
    required this.review,
  });

  final String id;
  final String name;
  final String review;

  factory AddReview.fromJson(Map<String, dynamic> json) => AddReview(
      id: json['id;'],
      name: json['name'],
      review: json['review'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'review': review,
  };

  @override
  List<Object?> get props => [id, name, review];
}