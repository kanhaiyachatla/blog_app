import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'Home/UI/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('Favourites');
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      title: 'Blogs App',
      home: HomeScreen(),
    );
  }

}

