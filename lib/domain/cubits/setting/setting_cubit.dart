import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/restaurant_repository.dart';
import '../../../helper/date_time_helper.dart';
import '../../../utils/background_service.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this._repository) : super(const SettingState());

  final RestaurantRepository _repository;

  Future<bool> scheduledRestaurant(bool isScheduled) async {
    if (isScheduled) {
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      return await AndroidAlarmManager.cancel(1);
    }
  }

  Future<void> setPreferenceSetting(String keyStr, bool value) async {
    await _repository.setPreferenceBoolean(keyStr, value);
    emit(state.copyWith(isScheduled: value));
  }


  Future<void> getPreferenceSetting(String keyStr) async {
    var value = await _repository.getPreferenceBoolean(keyStr);
    emit(state.copyWith(isScheduled: value));
  }
}
