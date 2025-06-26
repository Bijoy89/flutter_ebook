import 'package:flutter_ebook/Pages/WelcomePage.dart';
import 'package:get/get.dart';

class SplaceController extends GetxController
{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    splaceController();
  }

  void splaceController()
  {
    Future.delayed(Duration(seconds: 4), () {
      Get.offAll(Welcomepage());
    });
  }
}