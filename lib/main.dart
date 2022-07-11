import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/detail/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/presentation/favorite/pages/favorite_page.dart';
import 'package:restaurant_app/presentation/list/pages/restaurant_list_page.dart';
import 'package:restaurant_app/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/restaurant_repository.dart';
import 'data/services/restaurant_api.dart';
import 'data/services/restaurant_database.dart';
import 'domain/cubits/detail/restaurant_detail_cubit.dart';
import 'domain/cubits/favorite/favorite_cubit.dart';
import 'domain/cubits/list/restaurant_list_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RestaurantRepository _restaurantRepository = RestaurantRepository(
    restaurantApi: RestaurantApi(),
    restaurantDatabase: RestaurantDatabase.instance,
  );

  late RestaurantListCubit _restaurantsCubit;
  late FavoriteCubit _favoriteCubit;

  @override
  Widget build(BuildContext context) {
    _restaurantsCubit = RestaurantListCubit(_restaurantRepository);
    _favoriteCubit = FavoriteCubit(_restaurantRepository);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: restaurantListPageRoute,
      routes: {
        restaurantListPageRoute: (context) => BlocProvider.value(
              value: _restaurantsCubit..initCubit(),
              child: const RestaurantListPage(),
            ),
        restaurantDetailPageRoute: (context) => BlocProvider.value(
              value: RestaurantDetailCubit(_restaurantRepository),
              child: RestaurantDetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
            ),
        favoritePageRoute: (context) => BlocProvider.value(
          value: _favoriteCubit,
          child: const FavoritePage(),
        ),
      },
    );
  }

  @override
  void dispose() {
    _restaurantsCubit.close();
    super.dispose();
  }
}
