import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:prakriti_app/theme_data.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(24),
                ),
                depth: 5,
                intensity: 1,
                lightSource: LightSource.topLeft,
                color: Colors.grey[200]),
            child: Container(
              padding: const EdgeInsets.all(2),
              // width: double.infinity,
              child: TextField(
                cursorHeight: 24,
                cursorColor: Colors.black,
                controller: _searchController,
                onChanged: ((value) {}), // Implement on change for search
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
    );
  }
}
