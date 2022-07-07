import 'dart:convert';
import 'dart:developer';

import '../constant/api_constant.dart';
import 'package:http/http.dart' as http;

class RestaurantApi {
  Future<List<dynamic>> getRestaurantList() async {
    try {
      var url = Uri.parse(ApiConstant.restaurantListUrl);
      var response = await http.get(url);

      final dataJson = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        throw Exception(dataJson['message']);
      }

      if (dataJson.isEmpty) {
        throw Exception('Body is Empty');
      }

      return dataJson['restaurants'] as List;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<dynamic> getRestaurantDetail(String id) async {
    try {
      var url = Uri.parse('${ApiConstant.restaurantDetailUrl}/$id');
      var response = await http.get(url);

      final dataJson = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        throw Exception(dataJson['message']);
      }

      if (dataJson.isEmpty) {
        throw Exception('Body is Empty');
      }

      return dataJson['restaurant'];
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get RestaurantDetail');
    }
  }

  Future<List<dynamic>> getRestaurantSearch(String search) async {
    try {
      var url = Uri.parse(ApiConstant.restaurantSearchUrl).replace(queryParameters: {
        'q': search,
      });
      var response = await http.get(url);

      final dataJson = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        throw Exception(dataJson['message']);
      }

      if (dataJson.isEmpty) {
        throw Exception('Body is Empty');
      }

      return dataJson['restaurants'] as List;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> addReview(dynamic reviewJson) async {
    try {
      var url = Uri.parse(ApiConstant.restaurantReviewUrl);
      var response = await http.post(url,
          headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
          body: reviewJson,
          encoding: Encoding.getByName("utf-8"),
      );

      final dataJson = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        throw Exception(dataJson['message']);
      }

      if (dataJson.isEmpty) {
        throw Exception('Body is Empty');
      }

      return dataJson['customerReviews'] as List;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
