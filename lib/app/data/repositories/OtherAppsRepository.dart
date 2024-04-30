import 'dart:io';

import 'package:rune_of_the_day/app/business_logic/globals/globals.dart';
import 'package:rune_of_the_day/app/data/models/OtherApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OtherAppsRepository {

  Future<List<OtherApp>> getAll() async {
    Query<OtherApp> snapshot = FirebaseFirestore.instance
        .collection("${Globals.instance.localeType.name}/other_apps/${Platform.operatingSystem}")
        .withConverter<OtherApp>(
      fromFirestore: (snapshots, _) => OtherApp.fromJson(snapshots.data()!),
      toFirestore: (category, _) => category.toJson(),
    );

    QuerySnapshot<OtherApp> querySnapshot = await snapshot.get();
    List<OtherApp> otherApps = querySnapshot.docs.map((e) => e.data()).toList();
    return otherApps;
  }

}