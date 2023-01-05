import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:prakriti_app/providers/flora_provider.dart';
import 'package:prakriti_app/theme_data.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchBarWidget extends StatefulWidget {
  final TextEditingController searchController;
  Function reset;

  SearchBarWidget({
    required this.reset,
    required this.searchController,
    super.key,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
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
                key: const ValueKey("123"),
                cursorHeight: 24,
                cursorColor: Colors.black,
                controller: widget.searchController,
                onChanged: (value) {
                  Provider.of<FloraProvider>(
                    context,
                    listen: false,
                  ).applyFliter(value);
                }, // Implement on change for search
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
            style: const NeumorphicStyle(
              color: Color.fromARGB(255, 238, 238, 238),
              boxShape: NeumorphicBoxShape.circle(),
              intensity: 1,
              depth: 10,
            ),
            onPressed: () {
              if (widget.searchController.text.isNotEmpty) {
                setState(() {
                  widget.searchController.clear();
                  widget.reset();
                });
              }
            },
            child: Icon(
              widget.searchController.text.isEmpty
                  ? Icons.search
                  : Icons.close_rounded,
            ), // implement search functionality
          ),
        )
      ],
    );
  }
}
