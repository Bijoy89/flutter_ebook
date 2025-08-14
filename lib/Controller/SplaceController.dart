import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ebook/Pages/HomePage/Homepage.dart';
import 'package:flutter_ebook/Pages/WelcomePage.dart';
import 'package:get/get.dart';

class SplaceController extends GetxController
{
  final auth=FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    splaceController();
  }

  void splaceController()
  {
    Future.delayed(Duration(seconds: 8), () {
      if(auth.currentUser!=null){
        Get.offAll(HomePage(role: 'user',));
      }
      else{
        Get.offAll(Welcomepage());
      }
    });
  }
}