import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/restaurant.dart';
import '../../../data/repositories/restaurant_repository.dart';
import '../../../utils/result_status.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this._repository) : super(const FavoriteState(restaurants: []));

  final RestaurantRepository _repository;

  Future<void> fetchRestaurants() async {
    emit(state.copyWith(status: ResultStatus.inProgress));
    List<Restaurant> restaurants = await _repository.getRestaurantFavoriteList();

    if (restaurants.isEmpty) {
      emit(state.copyWith(status: ResultStatus.noData));
    } else {
      emit(state.copyWith(status: ResultStatus.success, restaurants: restaurants));
    }
  }
}
