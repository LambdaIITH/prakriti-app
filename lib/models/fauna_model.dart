class FaunaModel {
  final String scientificName;
  final String commonName;

  FaunaModel({
    required this.commonName,
    required this.scientificName,
  });

  static FaunaModel fromJson(Map<String, dynamic> json) {
    return FaunaModel(
      commonName: json["commonName"],
      scientificName: json["scientificName"],
    );
  }

  static Map<String, dynamic> toMap(FaunaModel model) {
    return {
      'commonName': model.commonName,
      'scientificName': model.scientificName,
    };
  }
}
