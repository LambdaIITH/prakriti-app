class ItemModel {
  final String commonName;
  final String scientificName;
  final String description;
  final dynamic dp;
  final dynamic otherPics;
  bool flora;
  bool fauna;

  ItemModel({
    required this.commonName,
    required this.description,
    required this.dp,
    required this.otherPics,
    required this.scientificName,
    required this.fauna,
    required this.flora,
  }) {
    fauna = false;
    flora = false;
  }
}
