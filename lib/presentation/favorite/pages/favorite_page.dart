import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';

import '../../../domain/cubits/favorite/favorite_cubit.dart';
import '../../../utils/result_status.dart';
import '../../list/widgets/restaurant_list_item.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavoriteCubit>(context);
    return FocusDetector(
      onFocusGained: () {
        cubit.fetchRestaurants();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text('Favorite'),
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state.status == ResultStatus.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ResultStatus.noData) {
              return const Center(
                child: Text(
                  'Tidak ada restaurant kesukaan',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantListItem(restaurant: state.restaurants[index]);
              },
            );
          },
        ),
      ),
    );
  }
}