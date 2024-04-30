part of 'language_cubit.dart';

class LanguageState {
  int? buttonId;
  String? locale;
  bool? firsTimeAppVisit;

  LanguageState({
    required this.buttonId,
    required this.locale,
    required this.firsTimeAppVisit,
  });

  factory LanguageState.fromJson(Map<String, dynamic> json) {
    return LanguageState(
      buttonId: json["buttonId"],
      locale: json["locale"],
      firsTimeAppVisit: json["firsTimeAppVisit"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "buttonId": this.buttonId,
      "firsTimeAppVisit": this.firsTimeAppVisit,
      "locale": this.locale,
    };
  }
}
