// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';

import 'package:fino_wise/Model/Login_model.dart';
import 'package:http/http.dart' as http;

class SigninApi {
  Future<LoginModel> apichangepassword({
    required String Country_Code,
    required String Mobile_No,
    required String Otp,
    required String Deviceid,
    required String Device_Type,
  }) async {
    var url = Uri.parse('http://hexeros.com/dev/finowise/api/V1/verify_otp');
    var response = await http.post(url,
        body: ({
          'country_code': Country_Code,
          'mobile': Mobile_No,
          'otp': Otp,
          'device_id': Deviceid,
          'device_type': Device_Type,
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    Encoding.getByName('utf-8');

    Map<String, dynamic> map = await jsonDecode(response.body);

    print(response.body);

    final data = LoginModel.fromJson(map);
    return data;
  }
}
