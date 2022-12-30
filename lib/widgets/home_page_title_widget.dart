import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:prakriti_app/theme_data.dart';

class HomePageTitleWidget extends StatelessWidget {
  const HomePageTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      child: Text(
        "Prakriti",
        style: titleFontStyle,
      ),
    );
  }
}
