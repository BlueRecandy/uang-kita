import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:uang_kita/screens/tambah_tagihan_screens.dart';
import 'package:uang_kita/widgets/screens/daftar_tagihan/tagihan_item_widget.dart';

class DaftarTagihanPage extends StatelessWidget {
  const DaftarTagihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    void _toTambahPengeluaran(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const TambahTagihanScreen();
      }));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tagihan'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _toTambahPengeluaran(context),
          child: const HeroIcon(HeroIcons.plus)),
      body: ListView(
        children: const <Widget>[
          TagihanItemWidget(
              price: 12000,
              title: 'Pecel Lele',
              description: 'Pesanan yang harus dibayar'),
          TagihanItemWidget(
              price: 20000,
              title: 'Laundry',
              description: 'Pesanan yang harus dibayar'),
        ],
      ),
    );
  }
}
