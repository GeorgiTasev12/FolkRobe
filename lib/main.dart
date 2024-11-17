import 'package:flutter/material.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/service/database_helper.dart';
import 'package:folk_robe/ui/costume_list_page.dart';
import 'package:folk_robe/ui/costumes_page.dart';
import 'package:folk_robe/ui/gender_page.dart';
import 'package:folk_robe/ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Constants.initialRouteString: (context) => const HomePage(),
        Constants.costumesPageRouteString: (context) => const CostumesPage(),
        Constants.genderPageRouteString: (context) => const GenderPage(),
        Constants.costumesListPageRouteString: (context) => const CostumeListPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Constants.initialRouteString,
    );
  }
}