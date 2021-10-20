import 'package:rune_of_the_day/app/constants/styles/icons.dart';

abstract class ImagePickerBase {
  String getImageById(int id);
}

class ImagePickerService extends ImagePickerBase {
  @override
  String getImageById(int id) {
    Map<int, String> idToImage = {
      1: fehu,
      2: urus,
      3: turisaz,
      4: ansuz,
      5: rajdo,
      6: kauna,
      7: gebo,
      8: vunya,
      9: hagalaz,
      10: nautiz,
      11: isa,
      12: jera,
      13: eyvaz,
      14: pert,
      15: algiz,
      16: solu,
      17: teivaz,
      18: berkana,
      19: evaz,
      20: mannaz,
      21: lagus,
      22: inguz,
      23: dagaz,
      24: opilla,
      25: odin,
    };

    return idToImage[id];
  }
}
