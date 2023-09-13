// To parse this JSON data, do
//
//     final ModelClass = ModelClassFromJson(jsonString);

import 'dart:convert';

// ignore: non_constant_identifier_names
ModelClass ModelClassFromJson(String str) =>
    ModelClass.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String ModelClassToJson(ModelClass data) => json.encode(data.toJson());

class ModelClass {
  final DateTime time;
  final String assetIdBase;
  final String assetIdQuote;
  final double rate;

  ModelClass({
    required this.time,
    required this.assetIdBase,
    required this.assetIdQuote,
    required this.rate,
  });

  factory ModelClass.fromJson(Map<String, dynamic> json) => ModelClass(
        time: DateTime.parse(json["time"]),
        assetIdBase: json["asset_id_base"],
        assetIdQuote: json["asset_id_quote"],
        rate: json["rate"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "time": time.toIso8601String(),
        "asset_id_base": assetIdBase,
        "asset_id_quote": assetIdQuote,
        "rate": rate,
      };
}
