import 'dart:convert';

import '../models/add_review.dart';
import '../models/customer_review.dart';
import '../models/restaurant.dart';
import '../models/restaurant_detail.dart';
import '../services/restaurant_api.dart';

class RestaurantRepository {
  RestaurantRepository({required this.restaurantApi});

  final RestaurantApi restaurantApi;

  Future<List<Restaurant>> fetchRestaurants() async {
    final listJson = await restaurantApi.getRestaurantList();
    List<Restaurant> list = listJson.map((item) => Restaurant.fromJson(item)).toList();

    return list;
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final dataJson = await restaurantApi.getRestaurantDetail(id);

    return RestaurantDetail.fromJson(dataJson);
  }

  Future<List<Restaurant>> searchRestaurants(String search) async {
    final listJson = await restaurantApi.getRestaurantSearch(search);
    List<Restaurant> list = listJson.map((item) => Restaurant.fromJson(item)).toList();

    return list;
  }

  Future<List<CustomerReview>> addReview(AddReview review) async {
    final reviewJson = json.encode(review.toJson());
    final listJson = await restaurantApi.addReview(reviewJson);

    List<CustomerReview> list = listJson.map((item) => CustomerReview.fromJson(item)).toList();

    return list;
  }
}