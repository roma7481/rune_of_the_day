import 'package:flutter/material.dart';

Widget appAdWidgetTag() {
  return _adWidgetTag();
}

Widget healingSoundsAdWidgetTag() {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: _adWidgetTag(),
  );
}

Widget _adWidgetTag() {
  return Container(
    width: 14,
    height: 14,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: Colors.blueAccent,
    ),
    child: const Center(
        child: Text(
          'AD',
          style: TextStyle(
            fontSize: 9,
            color: Colors.white,
          ),
        )),
  );
}