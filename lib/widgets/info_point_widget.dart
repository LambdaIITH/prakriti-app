import 'package:flutter/material.dart';
import 'package:prakriti_app/theme_data.dart';

class InfoPointWidget extends StatelessWidget {
  final String label;
  final String data;

  const InfoPointWidget({
    required this.label,
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: Ma,
        children: [
          Text(
            label,
            style: subtitleFontStyle,
          ),
          const SizedBox(
            width: 24,
          ),
          Text(
            data,
            style: regularTextFontStyle,
          )
        ],
      ),
    );
  }
}
