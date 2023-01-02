import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:prakriti_app/models/flora_model.dart';

class RequestsProvider extends ChangeNotifier {
  Stream<List<FloraModal>> readRequests() {
    return FirebaseFirestore.instance.collection('requests').snapshots().map(
          (snapshots) => snapshots.docs
              .map(
                (e) => FloraModal.fromJson(
                  e.data(),
                  e.id,
                ),
              )
              .toList(),
        );
  }
}
