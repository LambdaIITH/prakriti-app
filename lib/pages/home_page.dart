import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:prakriti_app/models/flora_model.dart';
import 'package:prakriti_app/pages/add_flora_page.dart';
import 'package:prakriti_app/pages/requests_page.dart';
import 'package:prakriti_app/providers/auth_provider.dart';
import 'package:prakriti_app/providers/flora_provider.dart';
import 'package:prakriti_app/widgets/grid_item_widget.dart';
import 'package:prakriti_app/widgets/home_page_title_widget.dart';
import 'package:prakriti_app/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  void reset() {
    setState(() {
      searchController.text = "";
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    String? email = AuthProvider().currentUser?.email;
    /********************** 
     * Admin Details here * 
     **********************/
    if (email == "ep20btech11025@iith.ac.in") {
      // print("WELCOME ADMIN");
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).isAdmin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.only(
            left: 8,
            top: 8,
            right: 8,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  const SizedBox(
                    width: double.maxFinite,
                    // color: Colors.black,
                    height: 50,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: NeumorphicButton(
                      onPressed: () => AuthProvider().signOut(),
                      style: const NeumorphicStyle(
                        // depth: 20,
                        intensity: 1,
                        lightSource: LightSource.topLeft,
                        boxShape: NeumorphicBoxShape.circle(),
                      ),
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NeumorphicButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddFloraPage(
                                  model: null,
                                ),
                              ),
                            );
                          },
                          style: const NeumorphicStyle(
                            // depth: 20,
                            color: Color.fromARGB(255, 238, 238, 238),
                            intensity: 1,
                            lightSource: LightSource.topLeft,
                            boxShape: NeumorphicBoxShape.circle(),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        NeumorphicButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RequestsPage(),
                              ),
                            );
                          },
                          style: const NeumorphicStyle(
                            // depth: 20,
                            color: Color.fromARGB(255, 238, 238, 238),
                            intensity: 1,
                            lightSource: LightSource.topLeft,
                            boxShape: NeumorphicBoxShape.circle(),
                          ),
                          child: const Icon(
                            Icons.library_add,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const HomePageTitleWidget(),
              /**********   Search Bar    ***********/
              SearchBarWidget(
                searchController: searchController,
                reset: reset,
              ),
              const SizedBox(
                height: 40,
              ),
              /* **********    ListView     *********** */
              // ListView.builder(itemBuilder: itemBuilder)
              Expanded(
                child: StreamBuilder<List<FloraModal>>(
                    stream: Provider.of<FloraProvider>(context).readFlora(),
                    builder: (context, snapshot) {
                      // print("error : ${snapshot.error}");
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.data == null) {
                        return Container(
                          child: Lottie.asset(
                            // fit this animation to screen
                            "assets/animations/loading.json",
                            fit: BoxFit.contain,
                          ),
                        );
                      }
                      List<FloraModal> floraList = [];
                      if (snapshot.hasData) {
                        Provider.of<FloraProvider>(
                          context,
                          listen: false,
                        ).setFloraList = snapshot.data!;
                        floraList =
                            Provider.of<FloraProvider>(context).floraList;
                        // print("text : ${searchController.text}");
                        if (searchController.text != "") {
                          floraList = floraList
                              .where((element) =>
                                  element.commonName
                                      .contains(searchController.text) ||
                                  element.scientificName
                                      .contains(searchController.text))
                              .toList();
                        }
                      }
                      return GridView.builder(
                        itemCount: floraList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: ((context, index) {
                          // print(floraList[index].imgUrl);
                          return GridItemWidget(
                            index: index,
                            commonName: floraList[index].commonName,
                            scientificName: floraList[index].scientificName,
                            imageUrl: floraList[index].imgUrl,
                          ); // pass arguments here
                        }),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
