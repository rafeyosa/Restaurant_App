import 'dart:convert';

import '../models/add_review.dart';
import '../models/customer_review.dart';
import '../models/restaurant.dart';
import '../models/restaurant_detail.dart';
import '../services/restaurant_api.dart';
import '../services/restaurant_database.dart';

class RestaurantRepository {
  RestaurantRepository({
    required this.restaurantApi,
    required this.restaurantDatabase,
  });

  final RestaurantApi restaurantApi;
  final RestaurantDatabase restaurantDatabase;

  Future<List<Restaurant>> fetchRestaurants() async {
    final listJson = await restaurantApi.getRestaurantList();
    List<Restaurant> list =
        listJson.map((item) => Restaurant.fromJson(item)).toList();

    return list;
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    var dataJson = await restaurantApi.getRestaurantDetail(id);

    return RestaurantDetail.fromJson(dataJson);
  }

  Future<List<Restaurant>> searchRestaurants(String search) async {
    final listJson = await restaurantApi.getRestaurantSearch(search);
    List<Restaurant> list =
        listJson.map((item) => Restaurant.fromJson(item)).toList();

    return list;
  }

  Future<List<CustomerReview>> addReview(AddReview review) async {
    final reviewJson = json.encode(review.toJson());
    final listJson = await restaurantApi.addReview(reviewJson);

    List<CustomerReview> list =
        listJson.map((item) => CustomerReview.fromJson(item)).toList();

    return list;
  }

  Future<void> addRestaurantFavorite(Restaurant restaurant) async =>
      await restaurantDatabase.addRestaurant(restaurant.toJson());

  Future<List<Restaurant>> getRestaurantFavoriteList() async {
    final listJson = await restaurantDatabase.getRestaurants();
    List<Restaurant> list =
        listJson.map((item) => Restaurant.fromJson(item)).toList();

    return list;
  }

  Future<bool> isRestaurantFavorite(String id) async {
    final dataJson = await restaurantDatabase.getRestaurantById(id);

    return dataJson.toString().isNotEmpty;
  }

  Future<void> removeRestaurantFavorite(String id) async =>
      await restaurantDatabase.deleteRestaurant(id);
}
