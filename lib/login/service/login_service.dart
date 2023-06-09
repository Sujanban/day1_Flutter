import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class LoginService {
  static Future<dynamic> login(String email, String password) async {
    Dio dio = Dio();
    var formData = FormData.fromMap({"email": email, "password": password});
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true));
    try {
      Response response = await dio.post("", data: formData);
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
