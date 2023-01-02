import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prakriti_app/models/flora_model.dart';
import 'package:prakriti_app/theme_data.dart';

class AddFloraPage extends StatefulWidget {
  const AddFloraPage({super.key});

  @override
  State<AddFloraPage> createState() => _AddFloraPageState();
}

class _AddFloraPageState extends State<AddFloraPage> {
  final _formKey = GlobalKey<FormState>();
  XFile? file;
  String commonName = "";
  String scientificName = "";
  String plantType = "";
  String plantFamily = "";
  String exposure = "";
  String seasonOfInterest = "";
  String height = "";
  String width = "";
  String waterNeeds = "";
  String soilType = "";
  String soilPh = "";
  String soilDrainage = "";
  String characteristics = "";
  String tolerance = "";
  String imgUrl = "";

  Widget fieldWidget(String hint) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        onSaved: ((newValue) {
          if (hint == "Common Name") {
            commonName = newValue!;
          } else if (hint == "Scientific Name") {
            scientificName = newValue!;
          } else if (hint == "Plant Type") {
            plantType = newValue!;
          } else if (hint == "Plant Family") {
            plantFamily = newValue!;
          } else if (hint == "Exposure") {
            exposure = newValue!;
          } else if (hint == "Season Of Interest") {
            seasonOfInterest = newValue!;
          } else if (hint == "Height") {
            height = newValue!;
          } else if (hint == "Water Needs") {
            waterNeeds = newValue!;
          } else if (hint == "Soil Type") {
            soilType = newValue!;
          } else if (hint == "Soil ph") {
            soilPh = newValue!;
          } else if (hint == "Soil Drainage") {
            soilDrainage = newValue!;
          } else if (hint == "Characteristics") {
            characteristics = newValue!;
          } else if (hint == "Tolerance") {
            tolerance = newValue!;
          }
        }),
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
              Container(
                width: 200,
                height: 200,
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: const Color.fromARGB(255, 238, 238, 238),
                //     width: 5,
                //     style: BorderStyle.solid,
                //   ),
                // ),
                margin: const EdgeInsets.all(12),
                // color: Colors.grey[50],
                alignment: Alignment.topCenter,
                child: SizedBox.expand(
                  child: NeumorphicButton(
                    padding: (file == null)
                        ? const EdgeInsets.all(75)
                        : const EdgeInsets.all(0),
                    style: const NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                      intensity: 1,
                      lightSource: LightSource.topLeft,
                      color: Color.fromARGB(255, 238, 238, 238),
                    ),
                    onPressed: (() async {
                      ImagePicker imagePicker = ImagePicker();

                      file = await imagePicker.pickImage(
                          source: ImageSource.camera);
                      setState(
                        () {},
                      );
                    }),
                    child: (file == null)
                        ? const Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.black,
                            size: 40,
                          )
                        : Image.file(
                            File(file!.path),
                            fit: BoxFit.cover,
                            // height: 150,
                            // width: 150,
                          ),
                  ),
                ),
              ),
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
                  onPressed: (() async {
                    if (_formKey.currentState!.validate() && file != null) {
                      _formKey.currentState!.save();
                      FloraModal newFlora = FloraModal(
                        characteristics: characteristics,
                        commonName: commonName,
                        exposure: exposure,
                        height: height,
                        imgUrl: imgUrl,
                        plantFamily: plantFamily,
                        plantType: plantType,
                        scientificName: scientificName,
                        seasonOfInterest: seasonOfInterest,
                        soilDrainage: soilDrainage,
                        soilPh: soilPh,
                        soilType: soilType,
                        tolerance: tolerance,
                        waterNeeds: waterNeeds,
                        width: width,
                      );
                      Reference refRoot = FirebaseStorage.instance.ref();
                      Reference refImgToUpload =
                          refRoot.child(newFlora.scientificName);

                      try {
                        await refImgToUpload.putFile(File(file!.path));
                        newFlora.imgUrl = await refImgToUpload.getDownloadURL();
                        // ignore: await_only_futures
                        final docRef = await FirebaseFirestore.instance
                            .collection("requests")
                            .doc();
                        await docRef.set(FloraModal.toMap(newFlora));

                      } catch (e) {
                        print("Error : ${e.toString()}");
                        /***********    Add error handeling here    ************/
                      }
                    }
                  }),
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
