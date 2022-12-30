class FloraModal {
  String commonName;
  String scientificName;
  String plantType;
  String plantFamily;
  String exposure;
  String seasonOfInterest;
  String minHeight;
  String maxHeight;
  String width;
  String waterNeeds;
  String soilType;
  String soilPh;
  String soilDrainage;
  String characteristics;
  String tolerance;
  String imgUrl;

  FloraModal({
    required this.characteristics,
    required this.commonName,
    required this.exposure,
    required this.minHeight,
    required this.maxHeight,
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
  });

  static FloraModal fromJson(Map<String, dynamic> json) {
    print("json : $json");
    return FloraModal(
      characteristics: json["characteristics"].toString(),
      commonName: json["commonName"].toString(),
      exposure: json["exposure"].toString(),
      minHeight: json["heightMin"].toString(),
      maxHeight: json["heightMax"].toString(),
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
    );
  }
}
