import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:prakriti_app/models/flora_model.dart';
import 'package:prakriti_app/pages/description_page.dart';
import 'package:prakriti_app/providers/auth_provider.dart';
import 'package:prakriti_app/providers/requests_provider.dart';
import 'package:prakriti_app/theme_data.dart';
import 'package:provider/provider.dart';

import '../models/request_model.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {


  Future<void> addFlora(FloraModal model) async {
    final docRef = FirebaseFirestore.instance.collection('flora').doc();
    await docRef.set(
      FloraModal.toMap(model),
    );
  }

  Future<void> deleteFloraRequest(Request req) async {
    /**
     * First delete from requests route
     */
    final docRef = FirebaseFirestore.instance
        .collection('requests')
        .doc(req.email)
        .collection('userRequests')
        .doc(req.model.scientificName);
    await docRef.delete();

    /**
     * Now delete from adminRequests route
     */

    final ref = FirebaseFirestore.instance
        .collection('adminRequests')
        .doc(req.model.id);

    await ref.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Requests",
          style: subtitleFontStyle,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: (Provider.of<AuthProvider>(context).isAdmin)
            ? RequestsProvider().readRequestsForAdmin()
            : RequestsProvider().readRequestsForUser(
                AuthProvider().currentUser!.email,
              ),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: Hero(
                  tag: snapshot.data![index].model.scientificName,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      snapshot.data![index].model.imgUrl,
                      // fit: BoxFit.cover,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                title: Text(
                  snapshot.data![index].model.commonName,
                  style: regularTitleFontStyle,
                ),
                subtitle: Text(
                  snapshot.data![index].model.scientificName,
                  style: scientificNameFontStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DescriptionPage(
                        flora: snapshot.data![index].model,
                      ),
                    ),
                  );
                },
                trailing: (Provider.of<AuthProvider>(context).isAdmin)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: (() async {
                              await addFlora(snapshot.data![index].model);
                              await deleteFloraRequest(
                                snapshot.data![index],
                              );
                            }), // implement this
                            icon: const Icon(
                              Icons.done,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: (() async {
                              await deleteFloraRequest(
                                snapshot.data![index],
                              );
                              /**
                               * Deleting image from the storage
                               */
                              Reference ref = FirebaseStorage.instance.ref();
                              Reference refToImgDelete = ref.child(
                                  snapshot.data![index].model.scientificName);
                              try {
                                await refToImgDelete.delete();
                              } catch (e) {
                                print(e.toString());
                              }
                            }), // implement this
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
              itemCount: snapshot.data?.length,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
