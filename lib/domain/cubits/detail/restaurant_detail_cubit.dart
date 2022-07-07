import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../data/models/add_review.dart';
import '../../../data/models/customer_review.dart';
import '../../../data/models/restaurant_detail.dart';
import '../../../data/repositories/restaurant_repository.dart';
import '../../../presentation/detail/form_inputs/text_input.dart';
import '../../../utils/result_status.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailCubit extends Cubit<RestaurantDetailState> {
  RestaurantDetailCubit(this._repository)
      : super(const RestaurantDetailState(
            restaurant: RestaurantDetail.empty, reviews: []));

  final RestaurantRepository _repository;

  Future<void> fetchRestaurantDetail(String id) async {
    emit(state.copyWith(status: ResultStatus.InProgress));

    try {
      RestaurantDetail restaurant = await _repository.getRestaurantDetail(id);

      if (restaurant.isEmpty) {
        emit(state.copyWith(status: ResultStatus.NoData));
      } else {
        emit(state.copyWith(
            status: ResultStatus.Success,
            restaurant: restaurant,
            reviews: restaurant.customerReviews));
      }
    } catch (_) {
      emit(state.copyWith(status: ResultStatus.Failure));
    }
  }

  Future<void> addNewReview(String id, String name, String review) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));

    final newReview = AddReview(
      id: id,
      name: name,
      review: review,
    );

    try {
      List<CustomerReview> reviews = await _repository.addReview(newReview);

      if (reviews.isEmpty) {
        emit(state.copyWith(formStatus: FormzStatus.submissionCanceled));
      } else {
        emit(state.copyWith(reviews: reviews, formStatus: FormzStatus.submissionSuccess));
      }
    } catch (_) {
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
    }
  }

  void nameChanged(String value) {
    final name = TextInput.dirty(value);
    emit(state.copyWith(
      name: name,
      formStatus: Formz.validate([name, state.review]),
    ));
  }

  void reviewChanged(String value) {
    final review = TextInput.dirty(value);
    emit(state.copyWith(
      review: review,
      formStatus: Formz.validate([state.name, review]),
    ));
  }

  void clearForm() {
    emit(
      state.copyWith(
        name: const TextInput.pure(),
        review: const TextInput.pure(),
        formStatus: FormzStatus.pure,
      ),
    );
  }
}
