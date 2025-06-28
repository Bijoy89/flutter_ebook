import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook/Pages/SplacePage/SplacePage.dart';
import 'package:flutter_ebook/Pages/WelcomePage.dart';
import 'package:get/get.dart';

import 'Config/Themes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //runApp(DevicePreview(builder: (context) => flutter_ebookmain()));
  runApp(const flutter_ebookmain());
}
class flutter_ebookmain extends StatelessWidget {
  const flutter_ebookmain({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Book Store',
      theme: lightTheme,
     // home: const Welcomepage(),
        home:SplacePage(),
    );
  }
}
