import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:restaurant_app/domain/cubits/detail/restaurant_detail_cubit.dart';

import '../../../utils/constant.dart';
import '../../../utils/result_status.dart';
import '../widgets/restaurant_menu_item.dart';
import '../widgets/review_item.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late ScrollController _scrollController;

  late RestaurantDetailCubit cubit;

  static const kExpandedHeight = 250.0;

  double get _horizontalTitlePadding {
    const kBasePadding = 15.0;
    const kMultiplier = 0.5;

    if (_scrollController.hasClients) {
      if (_scrollController.offset < (kExpandedHeight / 2)) {
        double fullExpanded = kBasePadding;
        return fullExpanded;
      }

      if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
        double noExpanded =
            (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier + kBasePadding;
        return noExpanded;
      }

      double halfExpanded =
          (_scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
              kBasePadding;
      return halfExpanded;
    }

    return kBasePadding;
  }

  double get _titleColor {
    if (_scrollController.hasClients) {
      if (_scrollController.offset < (kExpandedHeight / 2)) {
        return 0;
      }

      if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
        return 1;
      }

      return 0.5;
    }

    return 0;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    cubit = BlocProvider.of<RestaurantDetailCubit>(context);
    cubit.fetchRestaurantDetail(widget.id);
    cubit.checkFavorite(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RestaurantDetailCubit, RestaurantDetailState>(
        builder: (context, state) {
          if (state.status == ResultStatus.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ResultStatus.noData) {
            return const Center(
              child: Text(
                'Informasi tidak tersedia',
                style: TextStyle(
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

          return NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.lerp(
                        Colors.white,
                        Colors.black,
                        _titleColor,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  pinned: true,
                  expandedHeight: kExpandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      '$mediumPictureUrl/${state.restaurant.pictureId}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.error,
                            color: Colors.white70,
                            size: 200,
                          ),
                        );
                      },
                    ),
                    title: Text(
                      state.restaurant.name ?? '',
                      style: TextStyle(
                        color: Color.lerp(
                          Colors.white,
                          Colors.black,
                          _titleColor,
                        ),
                      ),
                    ),
                    titlePadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: _horizontalTitlePadding,
                    ),
                  ),
                ),
              ];
            },
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                state.restaurant.city ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 28,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                double.parse(state.restaurant.rating.toString())
                                    .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(width: 6),
                              FavoriteButton(
                                isFavorite: state.isFavorite,
                                valueChanged: (isFavorite) {
                                  cubit.setFavorite(isFavorite);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.restaurant.description ?? '',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Foods',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 5),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.restaurant.menus?.foods.length,
                          itemBuilder: (context, index) {
                            return RestaurantMenuItem(
                              name: state.restaurant.menus?.foods[index].name ??
                                  '',
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Drinks',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 5),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.restaurant.menus?.drinks.length,
                          itemBuilder: (context, index) {
                            return RestaurantMenuItem(
                              name:
                                  state.restaurant.menus?.drinks[index].name ??
                                      '',
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: Colors.grey.withOpacity(0.5),
                        height: 2,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          'Review',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 5),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.reviews.length,
                          itemBuilder: (context, index) {
                            if (state.formStatus == FormzStatus.submissionInProgress) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(50),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return ReviewItem(index: index);
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          primary: Colors.amber,
                          onPrimary: Colors.amberAccent,
                          minimumSize: const Size.fromHeight(40),
                        ),
                        onPressed: () {
                          _showReviewForm();
                        },
                        child: const Text(
                          'Berikan Ulasan Terbaikmu',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future _showReviewForm() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: cubit,
          child: AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
            content: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    cubit.clearForm();
                    Navigator.of(context).pop();
                  },
                ),
                BlocBuilder<RestaurantDetailCubit, RestaurantDetailState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 58),
                        TextField(
                          onChanged: (name) {
                            cubit.nameChanged(name);
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: state.name.invalid
                                    ? Colors.red
                                    : Colors.amber,
                              ),
                            ),
                            labelText: 'Nama',
                            floatingLabelStyle: TextStyle(
                              color: state.name.invalid
                                  ? Colors.red
                                  : Colors.amber,
                            ),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (review) {
                            cubit.reviewChanged(review);
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: state.name.invalid
                                    ? Colors.red
                                    : Colors.amber,
                              ),
                            ),
                            labelText: 'Ulasan',
                            floatingLabelStyle: TextStyle(
                              color: state.name.invalid
                                  ? Colors.red
                                  : Colors.amber,
                            ),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: Colors.amber,
                            ),
                            onPressed: state.formStatus.isValid
                                ? () {
                                    cubit.addNewReview(
                                      state.restaurant.id,
                                      state.name.value,
                                      state.review.value,
                                    );
                                    cubit.clearForm();
                                    Navigator.of(context).pop();
                                  } //cubit.signUpFormSubmitted()
                                : null,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'Berikan Ulasan',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(
      () => cubit.clearForm(),
    );
  }
}
