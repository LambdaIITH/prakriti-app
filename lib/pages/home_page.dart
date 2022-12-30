import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:prakriti_app/models/flora_model.dart';
import 'package:prakriti_app/models/model.dart';
import 'package:prakriti_app/providers/flora_provider.dart';
import 'package:prakriti_app/providers/auth_provider.dart';
import 'package:prakriti_app/theme_data.dart';
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
  List<ItemModel> _items = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(
                height: 50,
              ),
              const HomePageTitleWidget(),
              /**********   Search Bar    ***********/
              const SearchBarWidget(),
              const SizedBox(
                height: 40,
              ),
              /* **********    ListView     *********** */
              // ListView.builder(itemBuilder: itemBuilder)
              Expanded(
                child: StreamBuilder<List<FloraModal>>(
                    stream: Provider.of<FloraProvider>(context).readFlora(),
                    builder: (context, snapshot) {
                      print("error : ${snapshot.error}");
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
                        Provider.of<FloraProvider>(context).setFloraList =
                            snapshot.data!;
                        floraList =
                            Provider.of<FloraProvider>(context).floraList;
                        print(floraList[0].scientificName);
                      }
                      return GridView.builder(
                        itemCount: floraList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: ((context, index) {
                          return GridItemWidget(
                            commonName: floraList[index].commonName,
                            scientificName: floraList[index].scientificName,
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
