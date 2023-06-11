import 'package:day2/home/ui/home_page.dart';
import 'package:day2/login/service/login_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';

class LoginController extends GetxController {
  void loginUser({name, email, password,address}) async{
    await EasyLoading.show();

    try {
      var signupResponse =await LoginService.login(email, password);
      if(signupResponse!= null){
        var success = signupResponse["success"];
        await EasyLoading.dismiss();
        if(success==true){
          await EasyLoading.showSuccess("login success");
          Get.off(()=>HomePage());
        }
        else{
          await EasyLoading.showError("Invalid email or Password");
        }
      }
    } catch (e) {
      await EasyLoading.dismiss();
      debugPrint(e.toString());
      rethrow;
    }

  }
}
