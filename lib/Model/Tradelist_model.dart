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
  List<Userdata>? data;
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
        data: json["data"] == null
            ? null
            : List<Userdata>.from(
                json["data"].map((x) => Userdata.fromJson(x))),
        newTrades: json["new_trades"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "new_trades": newTrades,
      };
}

class Userdata {
  int? id;
  int? mentorId;
  String? type;
  int? entryPrice;
  String? name;
  String? stock;
  int? exitPrice;
  int? exitHigh;
  int? stopLossPrice;
  String? action;
  String? result;
  String? status;
  DateTime? postedDate;
  String? fee;
  int? isSubscribe;
  User? user;

  Userdata({
    this.id,
    this.mentorId,
    this.type,
    this.entryPrice,
    this.name,
    this.stock,
    this.exitPrice,
    this.exitHigh,
    this.stopLossPrice,
    this.action,
    this.result,
    this.status,
    this.postedDate,
    this.fee,
    this.isSubscribe,
    this.user,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        id: json["id"],
        mentorId: json["mentor_id"],
        type: json["type"],
        entryPrice: json["entry_price"],
        name: json["name"],
        stock: json["stock"],
        exitPrice: json["exit_price"],
        exitHigh: json["exit_high"],
        stopLossPrice: json["stop_loss_price"],
        action: json["action"],
        result: json["result"],
        status: json["status"],
        postedDate: DateTime.parse(json["posted_date"]),
        fee: json["fee"],
        isSubscribe: json["is_subscribe"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mentor_id": mentorId,
        "type": type,
        "entry_price": entryPrice,
        "name": name,
        "stock": stock,
        "exit_price": exitPrice,
        "exit_high": exitHigh,
        "stop_loss_price": stopLossPrice,
        "action": action,
        "result": result,
        "status": status,
        "posted_date":
            "${postedDate!.year.toString().padLeft(4, '0')}-${postedDate!.month.toString().padLeft(2, '0')}-${postedDate!.day.toString().padLeft(2, '0')}",
        "fee": fee,
        "is_subscribe": isSubscribe,
        "user": user!.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? profileImage;

  User({
    this.id,
    this.name,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_image": profileImage,
      };
}
