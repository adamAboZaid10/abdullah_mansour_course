// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

FavoritesModel welcomeFromJson(String str) => FavoritesModel.fromJson(json.decode(str));

String welcomeToJson(FavoritesModel data) => json.encode(data.toJson());

class FavoritesModel {
  bool? status;
  String? message;

  FavoritesModel({
    this.status,
    this.message,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) => FavoritesModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}