import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../models/request_model.dart';

// void getRequestUsers() {
//   // print("k");
//   // final ref = FirebaseFirestore.instance.collection("requests").snapshots().map(
//   //       (snapshot) => snapshot.docs.map((e) {
//   //         print(e.id);
//   //         return e.id;
//   //       }).toList(),
//   //     );

//   // List<String> tmp = [];
//   // ref.listen((event) {
//   //   print(event);
//   //   tmp = event;
//   // });
//   // return tmp;
//   final ref = FirebaseFirestore.instance.collection('requests');
//   print(ref);
// }

class RequestsProvider extends ChangeNotifier {
  // final CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('requests');

  // List<String> getshit() {
  //   List<String> ids = [];
  //   _collectionRef.get().then((value) {
  //     for (var i = 0; i < value.docs.length; i++) {
  //       ids.add(value.docs[i] as String);
  //     }
  //   });

  //   return ids;
  // }

  Stream<List<Request>> readRequestsForAdmin() {
    // print("RUNNING FOR ADMIN");
    // List<String> ids = getshit();
    return FirebaseFirestore.instance
        .collection('adminRequests')
        .snapshots()
        .map(
          (snapshots) => snapshots.docs
              .map(
                (e) => Request.fromJson(
                  e.data(),
                  e.id,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Request>> readRequestsForUser(String? email) {
    return FirebaseFirestore.instance
        .collection('requests')
        .doc(email)
        .collection('userRequests')
        .snapshots()
        .map(
          (snapshots) => snapshots.docs
              .map(
                (e) => Request.fromJson(
                  e.data(),
                  e.id,
                ),
              )
              .toList(),
        );
  }
}
