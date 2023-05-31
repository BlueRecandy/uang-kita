import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:uang_kita/screens/tambah_tagihan_screens.dart';
import 'package:uang_kita/widgets/icon_button_widget.dart';

class DaftarTagihanScreen extends StatefulWidget {
  const DaftarTagihanScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DaftarTagihanScreenState createState() => _DaftarTagihanScreenState();
}

class _DaftarTagihanScreenState extends State<DaftarTagihanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tagihan'),
      ),
      body: const Center(
        child: Text('Daftar Tagihan'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TambahTagihanScreen()));
        },
        child: const HeroIcon(HeroIcons.plus),
      ),
    );
  }
}
