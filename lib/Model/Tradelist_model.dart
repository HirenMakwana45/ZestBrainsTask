// To parse this JSON data, do
//
//     final tradeListModel = tradeListModelFromJson(jsonString);

import 'dart:convert';

TradeListModel tradeListModelFromJson(String str) =>
    TradeListModel.fromJson(json.decode(str));

String tradeListModelToJson(TradeListModel data) => json.encode(data.toJson());

class TradeListModel {
  int? status;
  String? message;
  List<dynamic>? data;
  int? newTrades;

  TradeListModel({
    this.status,
    this.message,
    this.data,
    this.newTrades,
  });

  factory TradeListModel.fromJson(Map<String, dynamic> json) => TradeListModel(
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        newTrades: json["new_trades"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x)),
        "new_trades": newTrades,
      };
}
