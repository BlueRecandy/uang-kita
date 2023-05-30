import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:uang_kita/db/sqlite.dart';
import 'package:uang_kita/models/bill_model.dart';
import 'package:uang_kita/screens/tambah_tagihan_screens.dart';
import 'package:uang_kita/widgets/screens/daftar_tagihan/tagihan_item_widget.dart';

class DaftarTagihanScreen extends StatefulWidget {
  const DaftarTagihanScreen({super.key});

  @override
  State<DaftarTagihanScreen> createState() => _DaftarTagihanScreenState();
}

class _DaftarTagihanScreenState extends State<DaftarTagihanScreen> {
  final List<Bill> daftarTagihan = [];

  @override
  void initState() {
    super.initState();
    loadTagihan();
  }

  void loadTagihan() async {
    final sqlite = SQLite.getInstance();
    final db = await sqlite.database;

    final result = await sqlite.billRepository.findAll(db);

    setState(() {
      daftarTagihan.clear();
      daftarTagihan.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    void toTambahPengeluaran(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const TambahTagihanScreen();
      }));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tagihan'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => toTambahPengeluaran(context),
          child: const HeroIcon(HeroIcons.plus)),
      body: daftarTagihan.isEmpty
          ? const Center(
              child: Text('Tidak ada tagihan'),
            )
          : ListView(
              children: daftarTagihan
                  .map((tagihan) => TagihanItemWidget(
                        tagihan: tagihan,
                      ))
                  .toList(),
            ),
    );
  }
}
