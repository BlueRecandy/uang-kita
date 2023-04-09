import 'package:flutter/material.dart';

class TambahPengeluaranScreen extends StatefulWidget {
  const TambahPengeluaranScreen({Key? key}) : super(key: key);

  @override
  State<TambahPengeluaranScreen> createState() =>
      _TambahPengeluaranScreenState();
}

class _TambahPengeluaranScreenState extends State<TambahPengeluaranScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengeluaran'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Text('Tambah Pengeluaran'),
          ],
        ),
      ),
    );
  }
}
