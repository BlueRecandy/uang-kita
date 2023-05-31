import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uang_kita/db/sqlite.dart';
import 'package:uang_kita/models/category_type_model.dart';

class TambahTagihanScreen extends StatefulWidget {
  const TambahTagihanScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TambahTagihanScreenState createState() => _TambahTagihanScreenState();
}

class _TambahTagihanScreenState extends State<TambahTagihanScreen> {
  final _formKey = GlobalKey<FormState>();

  final _judulController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _jatuhTempoController = TextEditingController();
  final _kategoriController = TextEditingController(text: getKategori().first);

  DateTime? jatuhTempo;

  static List<String> getKategori() {
    List<String> kategori =
        CategoryType.values.map((e) => e.displayName).toList();
    return kategori;
  }

  @override
  void dispose() {
    _judulController.dispose();
    _jumlahController.dispose();
    _jatuhTempoController.dispose();
    _kategoriController.dispose();
    super.dispose();
  }

  TextFormField _buildTextInputField(
      {required TextEditingController controller,
      required String label,
      String? errorMessage}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color.fromARGB(255, 235, 235, 235),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 13.0)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage ?? '$label tidak boleh kosong';
        }
        return null;
      },
    );
  }

  TextFormField _buildIntegerInputField(
      {required TextEditingController controller,
      required String label,
      String? errorMessage}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color.fromARGB(255, 235, 235, 235),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 13.0)),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage ?? '$label tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildJatuhTempoInput() {
    return TextFormField(
      controller: _jatuhTempoController,
      decoration: const InputDecoration(
        labelText: "Jatuh Tempo",
        errorStyle: TextStyle(color: Colors.red, fontSize: 13.0),
      ),
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Jatuh tempo tidak boleh kosong';
        }
        return null;
      },
      onTap: () async {
        final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2027));
        if (picked != null) {
          setState(() {
            jatuhTempo = picked;
            final String formattedDate =
                "${picked.day}/${picked.month}/${picked.year}";
            _jatuhTempoController.text = formattedDate;
          });
        }
      },
    );
  }

  bool _isInputValid() {
    return _formKey.currentState!.validate();
  }

  Map<String, dynamic> prepareData() {
    String kategoriRaw = _kategoriController.value.text;
    CategoryType kategori = CategoryType.values
        .where((element) => element.displayName == kategoriRaw)
        .first;

    final data = {
      'title': _judulController.value.text,
      'amount': int.parse(_jumlahController.value.text),
      'due_date': jatuhTempo!.toIso8601String(),
      'category': kategori
    };

    return data;
  }

  void showSuccessResponse() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Tagihan ditambah')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Tambah Tagihan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildTextInputField(
                        controller: _judulController, label: 'Judul')),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildIntegerInputField(
                        controller: _jumlahController,
                        label: 'Jumlah Tagihan')),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildJatuhTempoInput()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: "Kategori",
                      filled: true,
                      fillColor: Color.fromARGB(255, 235, 235, 235),
                    ),
                    value: _kategoriController.value.text,
                    items: getKategori()
                        .map((kategori) => DropdownMenuItem(
                              value: kategori,
                              child: Text(kategori),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _kategoriController.text = value!;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (!_isInputValid()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Mohon isi semua field dengan benar')));
                        return;
                      }

                      final data = prepareData();

                      final sqlite = SQLite.getInstance();
                      final db = await sqlite.database;

                      await sqlite.billRepository.insert(db, data);

                      showSuccessResponse();
                    },
                    child: const Text('Tambah')),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
