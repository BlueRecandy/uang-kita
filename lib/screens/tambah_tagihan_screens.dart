import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _kategoriController = TextEditingController();

  DateTime? _jatuhTempo;

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
          errorStyle: TextStyle(color: Colors.red, fontSize: 13.0)),
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
          errorStyle: TextStyle(color: Colors.red, fontSize: 13.0)),
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
            _jatuhTempo = picked;
            final String formattedDate =
                "${picked.day}/${picked.month}/${picked.year}";
            _jatuhTempoController.text = formattedDate;
          });
        }
      },
    );
  }

  final _dropdownCategoryItems = CategoryType.values
      .map((e) => DropdownMenuItem(
            value: e.displayName,
            child: Text(e.displayName),
          ))
      .toList();

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
                    value: _dropdownCategoryItems.first.value,
                    items: CategoryType.values
                        .map((e) => DropdownMenuItem(
                              value: e.displayName,
                              child: Text(e.displayName),
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
                    onPressed: () {
                      // TODO: Validasi disini gan
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Berhasil ditambah')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Kolom kosong')));
                      }
                      String judul = _judulController.text;
                      int jumlah = int.parse(_jumlahController.text);
                      String kategori = _kategoriController.text;

                      // TODO: Do something with the data, e.g. add to a database
                      print('Judul: $judul');
                      print('Jumlah: $jumlah');
                      print('Jatuh Tempo: $_jatuhTempo');
                      print('Kategori: $kategori');
                    },
                    child: const Text('Tambah'))
              ],
            ),
          )),
        ),
      ),
    );
  }
}
