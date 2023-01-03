import 'package:prakriti_app/models/flora_model.dart';

class Request {
  final FloraModal model;
  final String email;
  Request({
    required this.model,
    required this.email,
  });

  static Request fromJson(Map<String, dynamic> json, String id) {
    FloraModal model = FloraModal.fromJson(json, id);
    return Request(
      model: model,
      email: json['email'].toString(),
    );
  }
}
