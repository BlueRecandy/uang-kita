import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:uang_kita/widgets/button_widget.dart';
import 'package:uang_kita/widgets/icon_button_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'PlusJakartaSans',
          textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 24),
              bodyMedium: TextStyle(fontSize: 20),
              bodySmall: TextStyle(fontSize: 16),
              labelLarge:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
      home: Scaffold(
          body: SafeArea(
              child: Column(
        children: [
          IconButtonWidget(
            icon: HeroIcons.home,
            onPressed: () {},
            style: HeroIconStyle.outline,
          )
        ],
      ))),
    );
  }
}
