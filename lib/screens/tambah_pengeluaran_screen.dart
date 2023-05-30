import 'package:flutter/material.dart';
import 'package:uang_kita/db/sqlite.dart';
import 'package:uang_kita/models/category_type_model.dart';
import 'package:uang_kita/screens/daftar_pengeluaran_screen.dart';
import '../widgets/screens/tambah_pengeluaran/save_button.dart';
import '../widgets/screens/tambah_pengeluaran/textfield_judul.dart';
import '../widgets/screens/tambah_pengeluaran/textfield_jumlah.dart';
import '../widgets/screens/tambah_pengeluaran/textfield_kategori.dart';
import '../widgets/screens/tambah_pengeluaran/textfield_tanggal.dart';

class TambahPengeluaranScreen extends StatefulWidget {
  const TambahPengeluaranScreen({Key? key}) : super(key: key);

  @override
  State<TambahPengeluaranScreen> createState() =>
      _TambahPengeluaranScreenState();
}

class _TambahPengeluaranScreenState extends State<TambahPengeluaranScreen> {
  // Deklarasi variabel untuk textfield judul
  final TextEditingController titleController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();

  // Deklarasi variabel untuk dropdown
  CategoryType? selectedCategory;
  // List untuk dropdown katagori
  final katagoriList = CategoryType.values
      .map((e) => CategoryTypeModel(type: e, icon: e.icon))
      .toList();
  // Deklarasi variabel untuk textfield jumlah
  final TextEditingController amountController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();
  // Deklarasi variabel untuk textfield tanggal
  DateTime initialDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // Background Container
            backgroundContainer(context),
            Positioned(
              top: 120,
              // Main Container
              child: mainContainer(),
            ),
          ],
        ),
      ),
    );
  }

  // Method untuk membuat main container
  Container mainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 340,
      child: Column(
        children: [
          // textfield judul
          const SizedBox(height: 50),
          JudulTextField(
              controller: titleController, focusNode: titleFocusNode),
          // textfield katagori
          const SizedBox(height: 30),
          DropdownCategoryItems(
            items: katagoriList,
            hint: 'Kategori',
            onChanged: (value) {
              setState(() {
                // selectedCategory = CategoryType.values
                //     .firstWhere((element) => element.displayName == value);
                // selectedCategory = categoryTypeMap.entries
                //     .firstWhere((entry) => entry.value == value)
                //     .key;
                //print(value);
                selectedCategory = categoryTypeMap[value];
                print(selectedCategory);
              });
            },
          ),
          //textfield jumlah
          const SizedBox(height: 30),
          AmountTextField(
            focusNode: amountFocusNode,
            controller: amountController,
          ),
          // textfield tanggal
          const SizedBox(height: 30),
          DateTimePicker(
              initialDate: initialDate,
              onDateChanged: (value) {
                setState(() {
                  initialDate = value;
                });
              }),
          // button save
          const SizedBox(height: 70),
          SaveButton(
            onTap: () async {
              // TODO: Validasi data yang akan di input
              print(titleController.value.text);
              print(selectedCategory);
              print(amountController.value.text);

              if (titleController.value.text.isEmpty ||
                  selectedCategory == null ||
                  amountController.value.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data tidak boleh kosong'),
                  ),
                );
                return;
              } else {
                // TODO: Simpan data ke database
                final sqlite = SQLite.getInstance();
                final db = await sqlite.database;
                await sqlite.expenseRepository.insert(db, {
                  'title': titleController.value.text,
                  'category': selectedCategory,
                  'amount': amountController.value.text,
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data berhasil disimpan'),
                  ),
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DaftarPengeluaranScreen()));
              }
            },
          ),
        ],
      ),
    );
  }

  // Method untuk membuat background container
  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Text(
                      'Tambah Pengeluaran',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
