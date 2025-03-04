import 'package:flutter/material.dart';
import 'package:newproject/bottomNavigation/bottomNavigation.dart';
import 'package:newproject/provider/newsProvider.dart';
import 'package:newproject/screens/favorite.dart';
import 'package:newproject/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Bottomnavigation(),
      ),
    );
  }
}
