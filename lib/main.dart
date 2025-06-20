import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook/Pages/WelcomePage.dart';
import 'package:get/get.dart';

import 'Config/Themes.dart';

void main() {
  runApp(DevicePreview(builder: (context) => flutter_ebookmain()));
}
class flutter_ebookmain extends StatelessWidget {
  const flutter_ebookmain({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Book Store',
      theme: lightTheme,
      home: const Welcomepage(),

    );
  }
}
