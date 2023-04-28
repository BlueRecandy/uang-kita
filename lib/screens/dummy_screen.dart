import 'package:flutter/material.dart';
import 'package:uang_kita/screens/halaman%20Daftar%20Tagihan.dart';

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DaftarTagihanPage(),
    );
  }
}
