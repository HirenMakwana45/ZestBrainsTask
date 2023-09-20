// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? status;
  String? message;
  Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? countryShortCode;
  String? countryCode;
  String? mobile;
  String? profileImage;
  String? referCode;
  String? notificationFlag;
  int? tradeCount;
  String? token;
  int? socialLogin;

  Data({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.countryShortCode,
    this.countryCode,
    this.mobile,
    this.profileImage,
    this.referCode,
    this.notificationFlag,
    this.tradeCount,
    this.token,
    this.socialLogin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        countryShortCode: json["country_short_code"],
        countryCode: json["country_code"],
        mobile: json["mobile"],
        profileImage: json["profile_image"],
        referCode: json["refer_code"],
        notificationFlag: json["notification_flag"],
        tradeCount: json["trade_count"],
        token: json["token"],
        socialLogin: json["social_login"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country_short_code": countryShortCode,
        "country_code": countryCode,
        "mobile": mobile,
        "profile_image": profileImage,
        "refer_code": referCode,
        "notification_flag": notificationFlag,
        "trade_count": tradeCount,
        "token": token,
        "social_login": socialLogin,
      };
}
