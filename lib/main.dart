import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/config_controller.dart';
import 'app/theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  Get.put(ConfigController());

  runApp(const ConfigEditorApp());
}

class ConfigEditorApp extends StatelessWidget {
  const ConfigEditorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Temple Alarm Editor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const HomeScreen(),
    );
  }
}
