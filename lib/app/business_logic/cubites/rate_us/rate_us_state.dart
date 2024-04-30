part of 'rate_us_cubit.dart';

class RateUsState {
  int? minLaunches;
  bool? doNotShowAgain;
  int? remindLaunches;
  int? numTimesLaunched;
  bool? shouldShowDialog;

  RateUsState({
    required this.minLaunches,
    required this.doNotShowAgain,
    required this.remindLaunches,
    required this.numTimesLaunched,
    required this.shouldShowDialog,
  });

  factory RateUsState.fromMap(Map<String, dynamic> map) {
    return new RateUsState(
      minLaunches: map['minLaunches'] as int?,
      doNotShowAgain: map['doNotShowAgain'] as bool?,
      remindLaunches: map['remindLaunches'] as int?,
      numTimesLaunched: map['numTimesLaunched'] as int?,
      shouldShowDialog: map['shouldShowDialog'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'minLaunches': this.minLaunches,
      'doNotShowAgain': this.doNotShowAgain,
      'remindLaunches': this.remindLaunches,
      'numTimesLaunched': this.numTimesLaunched,
      'shouldShowDialog': this.shouldShowDialog,
    } as Map<String, dynamic>;
  }

  RateUsState copyWith({
    int? minLaunches,
    bool? doNotShowAgain,
    int? remindLaunches,
    int? numTimesLaunched,
    bool? shouldShowDialog,
  }) {
    return new RateUsState(
      minLaunches: minLaunches ?? this.minLaunches,
      doNotShowAgain: doNotShowAgain ?? this.doNotShowAgain,
      remindLaunches: remindLaunches ?? this.remindLaunches,
      numTimesLaunched: numTimesLaunched ?? this.numTimesLaunched,
      shouldShowDialog: shouldShowDialog ?? this.shouldShowDialog,
    );
  }
}
