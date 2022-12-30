import 'package:flutter/material.dart';
import 'package:prakriti_app/models/flora_model.dart';
import 'package:prakriti_app/theme_data.dart';

class DescriptionPage extends StatefulWidget {
  final FloraModal flora;
  const DescriptionPage({
    required this.flora,
    super.key,
  });

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(widget.flora.imgUrl),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.flora.commonName,
                style: subtitleFontStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.flora.scientificName,
                style: scientificNameFontStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              /***********   Add info point widget here   *************/
            ],
          ),
        ),
      ),
    );
  }
}
