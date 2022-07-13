import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/utils/result_status.dart';

import '../../../data/models/restaurant.dart';
import '../../../data/repositories/restaurant_repository.dart';

part 'restaurant_list_state.dart';

class RestaurantListCubit extends Cubit<RestaurantListState> {
  RestaurantListCubit(this._repository)
      : super(const RestaurantListState(
          restaurants: [],
          restaurantsSearch: [],
        ));

  final RestaurantRepository _repository;

  Future<void> initCubit() async {
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    emit(state.copyWith(status: ResultStatus.inProgress));

    try {
      List<Restaurant> restaurants = await _repository.fetchRestaurants();

      if (restaurants.isEmpty) {
        emit(state.copyWith(status: ResultStatus.noData));
      } else {
        emit(state.copyWith(
          status: ResultStatus.success,
          restaurants: restaurants,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: ResultStatus.failure));
    }
  }

  void isSearching() {
    emit(state.copyWith(isSearching: true));
  }

  void searchChanged(String value) {
    emit(state.copyWith(isSearching: true, search: value));
  }

  void searchClear() {
    emit(state.copyWith(
      isSearching: false,
      search: '',
      restaurantsSearch: [],
    ));

    if (state.restaurants.isEmpty) {
      fetchRestaurants();
    } else {
      emit(state.copyWith(status: ResultStatus.success));
    }
  }

  Future<void> searchRestaurants(String search) async {
    emit(state.copyWith(status: ResultStatus.inProgress));

    try {
      List<Restaurant> restaurants =
          await _repository.searchRestaurants(search);

      if (restaurants.isEmpty) {
        emit(state.copyWith(status: ResultStatus.noData));
      } else {
        emit(state.copyWith(
          status: ResultStatus.success,
          restaurantsSearch: restaurants,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: ResultStatus.failure));
    }
  }
}