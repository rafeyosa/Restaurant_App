part of 'setting_cubit.dart';

class SettingState extends Equatable {
  const SettingState({
    this.isScheduled = false,
  });

  final bool isScheduled;

  @override
  List<Object> get props => [isScheduled];

  SettingState copyWith({
    bool? isScheduled,
  }) {
    return SettingState(
      isScheduled: isScheduled ?? this.isScheduled,
    );
  }
}
