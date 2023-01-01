import 'package:flutter/material.dart';
import 'package:prakriti_app/theme_data.dart';

class AddFloraPage extends StatefulWidget {
  const AddFloraPage({super.key});

  @override
  State<AddFloraPage> createState() => _AddFloraPageState();
}

class _AddFloraPageState extends State<AddFloraPage> {
  final _formKey = GlobalKey<FormState>();

  Widget fieldWidget(String hint) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Empty fields a re not allowed";
          }
          return null;
        },
        decoration: InputDecoration(
          // hintStyle: regularTextFontStyle,
          label: Text(
            hint,
            style: commonNameFontStyle,
          ),
          floatingLabelStyle: commonNameFontStyle,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusColor: Colors.black,
          // hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          padding: const EdgeInsets.fromLTRB(
            0,
            8,
            0,
            0,
          ),
          width: double.infinity,
          child: Text(
            "New Flora",
            style: titleFontStyle,
            textAlign: TextAlign.center,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 32,
          ),
          onPressed: (() {
            Navigator.of(context).pop();
          }),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /************     Complete this SHIT !!! *******/

              fieldWidget("Common Name"),
              fieldWidget("Scientific Name"),
              fieldWidget("Plant Type"),
              fieldWidget("Plant Family"),
              fieldWidget("Exposure"),
              fieldWidget("Season Of Interest"),
              fieldWidget("Height"),
              fieldWidget("Water Needs"),
              fieldWidget("Soil Type"),
              fieldWidget("Soil ph"),
              fieldWidget("Soil Drainage"),
              fieldWidget("Characteristics"),
              fieldWidget("Tolerance"),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: (() {}),
                  child: Text(
                    "Submit",
                    style: subtitleFontStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
