part of 'restaurant_detail_cubit.dart';

class RestaurantDetailState extends Equatable {
  const RestaurantDetailState({
    this.status = ResultStatus.pure,
    required this.restaurant,
    required this.reviews,
    this.formStatus = FormzStatus.pure,
    this.name = const TextInput.pure(),
    this.review = const TextInput.pure(),
    this.isFavorite = false,
  });

  final ResultStatus status;
  final RestaurantDetail restaurant;
  final List<CustomerReview> reviews;
  final FormzStatus formStatus;
  final TextInput name;
  final TextInput review;
  final bool isFavorite;

  @override
  List<Object> get props => [status, restaurant, reviews, formStatus, name, review, isFavorite];

  RestaurantDetailState copyWith({
    ResultStatus? status,
    RestaurantDetail? restaurant,
    List<CustomerReview>? reviews,
    FormzStatus? formStatus,
    TextInput? name,
    TextInput? review,
    bool? isFavorite,
  }) {
    return RestaurantDetailState(
      status: status ?? this.status,
      restaurant: restaurant ?? this.restaurant,
      reviews: reviews ?? this.reviews,
      formStatus: formStatus ?? this.formStatus,
      name: name ?? this.name,
      review: review ?? this.review,
      isFavorite: isFavorite ?? this.isFavorite
    );
  }
}
