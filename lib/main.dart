import 'package:flutter/material.dart';
import 'package:uang_kita/screens/home_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'PlusJakartaSans',
            textTheme: TextTheme(
              displayLarge: TextStyle(fontSize: 32.sp),
              displayMedium: TextStyle(fontSize: 28.sp),
              displaySmall: TextStyle(fontSize: 24.sp),
              bodyLarge: TextStyle(fontSize: 20.sp),
              bodyMedium: TextStyle(fontSize: 18.sp),
              bodySmall: TextStyle(fontSize: 16.sp),
              labelLarge: TextStyle(fontSize: 14.sp),
              labelMedium: TextStyle(fontSize: 12.sp),
              labelSmall: TextStyle(fontSize: 10.sp),
            ),
          ),
          home: const Scaffold(body: SafeArea(child: HomeScreen())),
        );
      },
    );
  }
}
