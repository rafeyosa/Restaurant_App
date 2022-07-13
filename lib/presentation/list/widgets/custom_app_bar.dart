import 'dart:async';
import 'package:stream_transform/stream_transform.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/domain/cubits/list/restaurant_list_cubit.dart';

import '../../../constant/router_constant.dart';
import '../../../utils/navigation.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key}) : super(key: key);

  final StreamController<String> streamController = StreamController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<RestaurantListCubit>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Restaurant',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigation.intent(favoritePageRoute);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigation.intent(settingPageRoute);
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.only(
            left: 16,
            top: 2,
            bottom: 2,
          ),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color.fromRGBO(214, 214, 214, 1),
            ),
          ),
          child: Center(
            child: BlocBuilder<RestaurantListCubit, RestaurantListState>(
              builder: (context, state) {
                streamController.stream
                    .debounce(const Duration(seconds: 1))
                    .listen((search) => {
                      cubit.searchRestaurants(search)
                    });
                if (state.isSearching) {
                  return TextField(
                    onTap: () => cubit.isSearching(),
                    onChanged: (search) {
                      cubit.searchChanged(search);
                      streamController.add(search);
                    },
                    decoration: InputDecoration(
                      hintText: 'Where do you want to eat ?',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.grey),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          cubit.searchClear();
                        },
                      ),
                    ),
                  );
                } else {
                  return TextField(
                    onTap: () => cubit.isSearching(),
                    controller: TextEditingController(text: ''),
                    decoration: const InputDecoration(
                        hintText: 'Where do you want to eat ?',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search, color: Colors.grey)),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}