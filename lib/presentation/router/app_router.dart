import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/constant/router_constant.dart';

import '../../data/repositories/restaurant_repository.dart';
import '../../data/services/restaurant_api.dart';
import '../../data/services/restaurant_database.dart';
import '../../domain/cubits/detail/restaurant_detail_cubit.dart';
import '../../domain/cubits/favorite/favorite_cubit.dart';
import '../../domain/cubits/list/restaurant_list_cubit.dart';
import '../../domain/cubits/setting/setting_cubit.dart';
import '../../helper/notification_helper.dart';
import '../detail/pages/restaurant_detail_page.dart';
import '../favorite/pages/favorite_page.dart';
import '../list/pages/restaurant_list_page.dart';
import '../setting/pages/setting_page.dart';

class AppRouter {
  late RestaurantRepository repository;
  late RestaurantListCubit restaurantsCubit;
  late FavoriteCubit favoriteCubit;
  late SettingCubit settingCubit;
  late NotificationHelper notificationHelper;

  AppRouter() {
    repository = RestaurantRepository(
      restaurantApi: RestaurantApi(),
      restaurantDatabase: RestaurantDatabase(),
    );
    restaurantsCubit = RestaurantListCubit(repository);
    favoriteCubit = FavoriteCubit(repository);
    settingCubit = SettingCubit(repository);
    notificationHelper = NotificationHelper();
    notificationHelper.configureSelectNotificationSubject(restaurantDetailPageRoute);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case baseRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: restaurantsCubit..initCubit(),
            child: const RestaurantListPage(),
          ),
        );
      case restaurantDetailPageRoute:
        final id = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: RestaurantDetailCubit(repository),
            child: RestaurantDetailPage(id: id),
          ),
        );
      case favoritePageRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: favoriteCubit,
            child: const FavoritePage(),
          ),
        );
      case settingPageRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: settingCubit,
            child: const SettingPage(),
          ),
        );
      default:
        return null;
    }
  }
}
