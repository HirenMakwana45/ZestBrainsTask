// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';

import 'package:fino_wise/Model/Tradelist_model.dart';
import 'package:http/http.dart' as http;

class SigninApi {
  Future<TradeListModel> apichangepassword({
    required String Limit,
    required String bearerToken,
  }) async {
    var url =
        Uri.parse('http://hexeros.com/dev/finowise/api/V1/mentor/trade_list');
    var response = await http.post(url,
        body: ({
          'limit': Limit,
        }),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        });

    Encoding.getByName('utf-8');

    Map<String, dynamic> map = await jsonDecode(response.body);

    print(response.body);

    final data = TradeListModel.fromJson(map);
    return data;
  }
}
