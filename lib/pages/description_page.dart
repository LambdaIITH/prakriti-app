import 'package:flutter/material.dart';
import 'package:prakriti_app/models/flora_model.dart';
import 'package:prakriti_app/theme_data.dart';
import 'package:prakriti_app/widgets/info_point_widget.dart';

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Hero(
                    tag: "flora",
                    child: Image.network(
                      widget.flora.imgUrl,
                    ),
                  ),
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
                InfoPointWidget(
                  label: "Plant Type : ",
                  data: widget.flora.plantType,
                ),
                InfoPointWidget(
                  label: "Plant Family : ",
                  data: widget.flora.plantFamily,
                ),
                InfoPointWidget(
                  label: "Exposure : ",
                  data: widget.flora.exposure,
                ),
                InfoPointWidget(
                  label: "Season of interest : ",
                  data: widget.flora.seasonOfInterest,
                ),
                InfoPointWidget(
                  label: "Height : ",
                  data: "${widget.flora.minHeight}-${widget.flora.maxHeight}m",
                ),
                InfoPointWidget(
                  label: "Water needs : ",
                  data: widget.flora.waterNeeds,
                ),
                InfoPointWidget(
                  label: "Soil Type : ",
                  data: widget.flora.soilType,
                ),
                InfoPointWidget(
                  label: "Soil ph : ",
                  data: widget.flora.soilPh,
                ),
                InfoPointWidget(
                  label: "Soil Drainage : ",
                  data: widget.flora.soilDrainage,
                ),
                InfoPointWidget(
                  label: "Characteristics : ",
                  data: widget.flora.characteristics,
                ),
                InfoPointWidget(
                  label: "Tolerance : ",
                  data: widget.flora.tolerance,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
