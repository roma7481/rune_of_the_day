import 'package:flutter/material.dart';

Widget appAdWidgetTag() {
  return _adWidgetTag(Colors.blueAccent);
}

Widget healingSoundsAdWidgetTag() {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: _adWidgetTag(Colors.blueAccent),
  );
}

Widget _adWidgetTag(Color color) {
  return Container(
    width: 14,
    height: 14,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: color,
    ),
    child: const Center(
        child: Text(
          'AD',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        )),
  );
}