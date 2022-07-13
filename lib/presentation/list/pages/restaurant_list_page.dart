import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/domain/cubits/list/restaurant_list_cubit.dart';
import 'package:restaurant_app/utils/result_status.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/restaurant_list_item.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 120,
        elevation: 0.0,
        titleSpacing: 0,
        title: CustomAppBar(),
      ),
      body: BlocBuilder<RestaurantListCubit, RestaurantListState>(
        builder: (context, state) {
          if (state.status == ResultStatus.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ResultStatus.noData) {
            return Center(
              child: Text(
                state.isSearching
                    ? 'Restaurant tidak ditemukan'
                    : 'Tidak ada restaurant',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            );
          }

          if (state.status == ResultStatus.failure) {
            return const Center(
              child: Text(
                'Gagal mendapatkan data',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.isSearching
                ? state.restaurantsSearch.length
                : state.restaurants.length,
            itemBuilder: (context, index) {
              return state.isSearching
                  ? RestaurantListItem(
                      restaurant: state.restaurantsSearch[index])
                  : RestaurantListItem(restaurant: state.restaurants[index]);
            },
          );
        },
      ),
    );
  }
}