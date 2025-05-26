import 'package:flutter/material.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/database_costume_helper.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/home_page/page.dart';

import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseCostumeHelper.database;
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      navigatorKey: NavigationService.navigatorKey,
      home: const HomePage(),
    );
  }
}
