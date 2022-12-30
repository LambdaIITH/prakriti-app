import 'package:flutter/foundation.dart';
import 'package:prakriti_app/models/model.dart';

class ListItemProvider extends ChangeNotifier {
  final List<ItemModel> _items = [
    ItemModel(
      commonName: "Rose",
      description: "This is a rose",
      dp: null,
      otherPics: null,
      scientificName: "Rosa scientifica",
      fauna: false,
      flora: true,
    ),
    ItemModel(
      commonName: "daisey",
      description: "This is a daisey",
      dp: null,
      otherPics: null,
      scientificName: "Daisa Scientifica",
      fauna: false,
      flora: true,
    ),
    ItemModel(
        commonName: "Lion",
        description: "King of jungle",
        dp: null,
        otherPics: null,
        scientificName: "Panthera Leo",
        fauna: true,
        flora: false),
    ItemModel(
        commonName: "Tiger",
        description: "The real one",
        dp: null,
        otherPics: null,
        scientificName: "panthra tigris",
        fauna: true,
        flora: false),
  ];

  List<ItemModel> get items => [..._items];
}
