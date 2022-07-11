part of 'restaurant_list_cubit.dart';

class RestaurantListState extends Equatable {
  const RestaurantListState({
    this.status = ResultStatus.pure,
    required this.restaurants,
    this.isSearching = false,
    this.search = '',
    required this.restaurantsSearch,
  });

  final ResultStatus status;
  final List<Restaurant> restaurants;
  final bool isSearching;
  final String search;
  final List<Restaurant> restaurantsSearch;

  @override
  List<Object> get props => [
        status,
        restaurants,
        isSearching,
        search,
        restaurantsSearch,
      ];

  RestaurantListState copyWith({
    ResultStatus? status,
    List<Restaurant>? restaurants,
    bool? isSearching,
    String? search,
    List<Restaurant>? restaurantsSearch,
  }) {
    return RestaurantListState(
      status: status ?? this.status,
      restaurants: restaurants ?? this.restaurants,
      isSearching: isSearching ?? this.isSearching,
      search: search ?? this.search,
      restaurantsSearch: restaurantsSearch ?? this.restaurantsSearch,
    );
  }
}
