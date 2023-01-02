import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prakriti_app/models/flora_model.dart';
import 'package:prakriti_app/pages/description_page.dart';
import 'package:prakriti_app/providers/requests_provider.dart';
import 'package:prakriti_app/theme_data.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  Future<void> addFlora(FloraModal model) async {
    final docRef = await FirebaseFirestore.instance.collection('flora').doc();
    docRef.set(
      FloraModal.toMap(model),
    );
  }

  Future<void> deleteFloraRequest(String id) async {
    final docRef =
        await FirebaseFirestore.instance.collection('requests').doc(id);
    docRef.delete();
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
        stream: RequestsProvider().readRequests(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: Hero(
                  tag: 'flora',
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      snapshot.data![index].imgUrl,
                      // fit: BoxFit.cover,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                title: Text(
                  snapshot.data![index].commonName,
                  style: regularTitleFontStyle,
                ),
                subtitle: Text(
                  snapshot.data![index].scientificName,
                  style: scientificNameFontStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DescriptionPage(
                        flora: snapshot.data![index],
                      ),
                    ),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: (() async {
                        await addFlora(snapshot.data![index]);
                        await deleteFloraRequest(snapshot.data![index].id);
                      }), // implement this
                      icon: const Icon(
                        Icons.done,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: (() async {
                        await deleteFloraRequest(snapshot.data![index].id);
                      }), // implement this
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
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
