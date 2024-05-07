import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> with HydratedMixin {
  NotificationsCubit()
      : super(NotificationsState(
          isAlarmSet: false,
          hours: 8,
          minutes: 30,
        )){
    hydrate();
  }

  void emitSetAlarmTime(int hours, int minutes) {
    emit(state.copyWith(
      hours: hours,
      minutes: minutes,
    ));
  }

  void emitResetAlarm(bool? isActive, int? hours, int? minutes){
    emit(state.copyWith(
      isAlarmSet: isActive,
      hours: hours,
      minutes: minutes,
    ));
  }

  void emitSetAlarmState(bool isActive) {
    emit(state.copyWith(
      isAlarmSet: isActive,
    ));
  }

  @override
  NotificationsState fromJson(Map<String, dynamic> json) {
    return NotificationsState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(NotificationsState state) {
    return state.toMap();
  }
}
