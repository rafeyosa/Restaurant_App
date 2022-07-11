part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  const FavoriteState({
    this.status = ResultStatus.pure,
    required this.restaurants,
  });

  final ResultStatus status;
  final List<Restaurant> restaurants;

  @override
  List<Object> get props => [
        status,
        restaurants,
      ];

  FavoriteState copyWith({
    ResultStatus? status,
    List<Restaurant>? restaurants,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      restaurants: restaurants ?? this.restaurants,
    );
  }
}
