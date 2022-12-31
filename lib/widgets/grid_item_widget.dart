import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:prakriti_app/pages/description_page.dart';
import 'package:prakriti_app/providers/flora_provider.dart';
import 'package:prakriti_app/theme_data.dart';
import 'package:provider/provider.dart';

class GridItemWidget extends StatefulWidget {
  final String commonName;
  final String scientificName;
  final String imageUrl;
  final int index;

  const GridItemWidget({
    required this.commonName,
    required this.scientificName,
    required this.imageUrl,
    required this.index,
    super.key,
  });

  @override
  State<GridItemWidget> createState() => _GridItemWidgetState();
}

class _GridItemWidgetState extends State<GridItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DescriptionPage(
              flora: Provider.of<FloraProvider>(
                context,
                listen: false,
              ).floraList[widget.index],
            ),
          ),
        );
      }),
      child: Container(
        // height: 50,
        // width: 40,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Neumorphic(
              style: const NeumorphicStyle(
                shape: NeumorphicShape.concave,
                lightSource: LightSource.topLeft,
                intensity: 1,
                depth: 20,    // added, check if it's good or not
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: Container(
                height: 100,
                width: 100,
                // color: Colors.amber,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(221, 173, 172, 172),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.grey[200]!,
                      style: BorderStyle.solid,
                      width: 1.5,
                    )),
                child: Hero(
                  tag: "flora",
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                widget.commonName,
                style: commonNameFontStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                widget.scientificName,
                style: scientificNameFontStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
