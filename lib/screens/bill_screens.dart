import 'package:flutter/material.dart';
import 'package:uang_kita/models/category_type_model.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final _formKey = GlobalKey<FormState>();

  final _judulController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _jatuhTempoController = TextEditingController();
  final _kategoriController = TextEditingController();

  @override
  void dispose() {
    _judulController.dispose();
    _jumlahController.dispose();
    _jatuhTempoController.dispose();
    _kategoriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _judulController,
                  decoration: const InputDecoration(
                    labelText: "Judul",
                    filled: true,
                    fillColor: Color.fromARGB(255, 235, 235, 235),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul tidak boleh kosong';
                    }
                    return null;
                  },
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _jumlahController,
                  decoration: const InputDecoration(
                    labelText: "Jumlah",
                    filled: true,
                    fillColor: Color.fromARGB(255, 235, 235, 235),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah tidak boleh kosong';
                    }
                    return null;
                  },
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _jatuhTempoController,
                  decoration: const InputDecoration(
                    labelText: "Jatuh Tempo",
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2027));
                    if (picked != null) {
                      setState(() {
                        _jatuhTempoController.text = picked.toString();
                      });
                    }
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Kategori",
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 235, 235),
                ),
                value: _kategoriController.text,
                items: CategoryType.values
                    .map((e) => DropdownMenuItem(
                          value: e.displayName,
                          child: Text(e.displayName),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _kategoriController.text = value.toString();
                  });
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
