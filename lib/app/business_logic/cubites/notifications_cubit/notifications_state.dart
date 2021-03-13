part of 'notifications_cubit.dart';

class NotificationsState {
  bool isAlarmSet;
  int hours;
  int minutes;

  NotificationsState({
    @required this.isAlarmSet,
    @required this.hours,
    @required this.minutes,
  });

  NotificationsState copyWith({
    bool isAlarmSet,
    int hours,
    int minutes,
  }) {
    return new NotificationsState(
      isAlarmSet: isAlarmSet ?? this.isAlarmSet,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
    );
  }

  factory NotificationsState.fromMap(Map<String, dynamic> map) {
    return new NotificationsState(
      isAlarmSet: map['isAlarmSet'] as bool,
      hours: map['hours'] as int,
      minutes: map['minutes'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'isAlarmSet': this.isAlarmSet,
      'hours': this.hours,
      'minutes': this.minutes,
    } as Map<String, dynamic>;
  }
}
