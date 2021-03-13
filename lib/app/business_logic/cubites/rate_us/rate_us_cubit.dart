import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'rate_us_state.dart';

class RateUsCubit extends Cubit<RateUsState> with HydratedMixin {
  RateUsCubit()
      : super(RateUsState(
          minLaunches: 8,
          doNotShowAgain: false,
          remindLaunches: 8,
          numTimesLaunched: 0,
          shouldShowDialog: false,
        ));

  void emitIncreaseAppLaunchedCounter() {
    if (state.doNotShowAgain) {
      return;
    }
    emit(state.copyWith(
      numTimesLaunched: state.numTimesLaunched + 1,
    ));
    if (state.numTimesLaunched == state.minLaunches) {
      emitShowDialog();
    } else if (state.numTimesLaunched >=
        state.minLaunches + state.remindLaunches) {
      emitRemind();
    }
  }

  void emitShowDialog() {
    emit(state.copyWith(shouldShowDialog: true));
  }

  void emitStopShowing() {
    emit(state.copyWith(shouldShowDialog: false));
  }

  void emitRemind() {
    emit(state.copyWith(
        numTimesLaunched: state.numTimesLaunched - state.remindLaunches));
    emitShowDialog();
  }

  void emitDoNotShowAgain() {
    emit(state.copyWith(doNotShowAgain: true, shouldShowDialog: false));
  }

  @override
  RateUsState fromJson(Map<String, dynamic> map) {
    return RateUsState.fromMap(map);
  }

  @override
  Map<String, dynamic> toJson(RateUsState state) {
    return state.toMap();
  }
}
