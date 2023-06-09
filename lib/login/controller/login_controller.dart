import 'package:day2/login/service/login_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';

class LoginController extends GetxController {
  void loginUser({email, password}) async{
    await EasyLoading.show();
    try {
      var loginResponse =await LoginService.login(email, password);
      if(loginResponse!= null){
        await EasyLoading.dismiss();
      }
    } catch (e) {
      await EasyLoading.dismiss();
      debugPrint(e.toString());
      rethrow;
    }
  }
}
