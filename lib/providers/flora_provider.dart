import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prakriti_app/models/flora_model.dart';
import 'package:prakriti_app/models/user_model.dart';

class FloraProvider extends ChangeNotifier {
  List<FloraModal> _floraList = [];

  List<FloraModal> get floraList => [..._floraList];
  set setFloraList(List<FloraModal> list) {
    // print(list[0].characteristics);
    _floraList = list;
  }

  Stream<List<FloraModal>> readFlora() {
    return FirebaseFirestore.instance.collection('flora').snapshots().map(
          (snapshots) => snapshots.docs
              .map(
                (e) => FloraModal.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
  }
}
