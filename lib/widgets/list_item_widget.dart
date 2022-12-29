import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:prakriti_app/theme_data.dart';

class ListItemWidget extends StatefulWidget {
  const ListItemWidget({super.key});

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        /*
          * Implement the geture detector  
        */
      }),
      child: Container(
        // height: 50,
        // width: 40,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 100,
              width: 100,
              // color: Colors.amber,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Common Name",
                style: commonNameFontStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Scientific Name",
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
