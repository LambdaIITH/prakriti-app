import 'package:flutter/material.dart';
import 'package:prakriti_app/pages/description_page.dart';
import 'package:prakriti_app/providers/requests_provider.dart';
import 'package:prakriti_app/theme_data.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  get label => null;

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
                leading: CircleAvatar(
                  child: Hero(
                    tag: 'flora',
                    child: Image.network(
                      snapshot.data![index].imgUrl,
                      fit: BoxFit.cover,
                    ),
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
                      onPressed: (() {}), // implement this
                      icon: const Icon(
                        Icons.done,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: (() {}), // implement this
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
