class FloraModal {
  String commonName;
  String scientificName;
  String plantType;
  String plantFamily;
  String exposure;
  String seasonOfInterest;
  String height;
  String width;
  String waterNeeds;
  String soilType;
  String soilPh;
  String soilDrainage;
  String characteristics;
  String tolerance;
  String imgUrl;
  String id;

  FloraModal({
    required this.characteristics,
    required this.commonName,
    required this.exposure,
    required this.height,
    required this.plantFamily,
    required this.plantType,
    required this.scientificName,
    required this.seasonOfInterest,
    required this.soilDrainage,
    required this.soilPh,
    required this.soilType,
    required this.tolerance,
    required this.waterNeeds,
    required this.width,
    required this.imgUrl,
    required this.id,
  });

  static Map<String, dynamic> toMap(FloraModal model) {
    return {
      "commonName": model.commonName,
      "characteristics": model.characteristics,
      "exposure": model.exposure,
      "height": model.height,
      "plantFamily": model.plantFamily,
      "plantType": model.plantType,
      "scientificName": model.scientificName,
      "seasonOfInterest": model.seasonOfInterest,
      "soilDrainage": model.soilDrainage,
      "soilPh": model.soilPh,
      "soilType": model.soilType,
      "tolerance": model.tolerance,
      "waterNeeds": model.waterNeeds,
      "width": model.width,
      "imageUrl": model.imgUrl,
      "id": DateTime.now().toIso8601String(),
    };
  }

  static FloraModal fromJson(Map<String, dynamic> json, String id) {
    // print("json : $json");
    return FloraModal(
      characteristics: json["characteristics"].toString(),
      commonName: json["commonName"].toString(),
      exposure: json["exposure"].toString(),
      height: json["heightMin"].toString(),
      plantFamily: json["plantFamily"].toString(),
      plantType: json["plantType"].toString(),
      scientificName: json["scientificName"].toString(),
      seasonOfInterest: json["seasonOfInterest"].toString(),
      soilDrainage: json["soilDrainage"].toString(),
      soilPh: json["soilPh"].toString(),
      soilType: json["soilType"].toString(),
      tolerance: json["tolerance"].toString(),
      waterNeeds: json["waterNeeds"].toString(),
      width: json["width"].toString(),
      imgUrl: json["imageUrl"].toString(),
      id: id,
    );
  }
}
