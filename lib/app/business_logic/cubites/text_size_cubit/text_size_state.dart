part of 'text_size_cubit.dart';

class TextSizeState {
  TextSizeState({
    required this.buttonId,
    required this.textSize,
  });

  int? buttonId;
  double? textSize;

  factory TextSizeState.fromJson(Map<String, dynamic> json) {
    return TextSizeState(
      buttonId: json["buttonId"],
      textSize: json["textSize"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "buttonId": this.buttonId,
      "textSize": this.textSize,
    };
  }
}
