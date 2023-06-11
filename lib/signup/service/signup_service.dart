import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class SignupService {
  static Future<dynamic> register(String name, String email, String password, String address) async {
    Dio dio = Dio();
    var formData = FormData.fromMap({"name": name,"email": email, "password": password, "c_password": password, "address": address});
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true));
    try {
      Response response = await dio.post("https://ecom.stuschooler.com/api/register", data: formData);
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
