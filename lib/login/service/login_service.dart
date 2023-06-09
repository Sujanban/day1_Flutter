import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class LoginService {
  Future<dynamic> login() async {
    Dio dio = Dio();
    var formData = FormData.fromMap({"email": "", "password": ""});
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
