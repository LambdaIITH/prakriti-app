import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:prakriti_app/theme_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose(); // Search controller disposed
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
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Text(
                  "Prakriti",
                  style: titleFontStyle,
                ),
              ),
              /**********   Search Bar    ***********/
              Row(
                children: [
                  Expanded(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(24),
                          ),
                          depth: 5,
                          intensity: 0.7,
                          lightSource: LightSource.topLeft,
                          color: Colors.grey[200]),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        // width: double.infinity,
                        child: TextField(
                          cursorHeight: 24,
                          cursorColor: Colors.black,
                          controller: _searchController,
                          onChanged:
                              ((value) {}), // Implement on change for search
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: InputBorder.none,
                          ),
                          style: regularTextFontStyle,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: NeumorphicButton(
                      child: const Icon(Icons.search),
                      onPressed: (() {}), // implement search functionality
                    ),
                  )
                ],
              ),
              /* **********    ListView     *********** */
              
            ],
          ),
        ),
      ),
    );
  }
}
