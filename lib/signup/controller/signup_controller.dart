import 'package:day2/home/ui/home_page.dart';
import 'package:day2/login/service/login_service.dart';
import 'package:day2/login/ui/login_page.dart';
import 'package:day2/signup/service/signup_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';

class SignupController extends GetxController {
  void signupUser({name, email, password,address}) async{
    await EasyLoading.show();

    try {
      var loginResponse =await SignupService.register(name, email, password, address);
      if(loginResponse!= null){
        await EasyLoading.dismiss();
        await EasyLoading.showSuccess("Sucessfully Registered!");
        Get.off(()=>LoginPage());
      }
    } catch (e) {
      await EasyLoading.dismiss();
      await EasyLoading.showError("Oops something went wrong!");
      debugPrint(e.toString());
      rethrow;
    }
  }
}
