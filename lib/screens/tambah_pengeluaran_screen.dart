import 'package:flutter/material.dart';
import 'package:uang_kita/db/sqlite.dart';
import 'package:uang_kita/models/category_type_model.dart';

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
  DateTime expenseDate = DateTime.now();

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

  bool isInputValid() {
    final isTitleEmpty = titleController.value.text.isEmpty;
    final isCategoryEmpty = selectedCategory == null;
    final isAmountEmpty = amountController.value.text.isEmpty;

    return !isTitleEmpty && !isCategoryEmpty && !isAmountEmpty;
  }

  void showInvalidResponse() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data tidak boleh kosong'),
      ),
    );
  }

  void showSuccessResponse() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil disimpan'),
      ),
    );
    Navigator.of(context).pop();
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
              final category = CategoryType.values
                  .where((element) => element.displayName == value)
                  .first;

              setState(() {
                selectedCategory = category;
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
              initialDate: expenseDate,
              onDateChanged: (value) {
                setState(() {
                  expenseDate = value;
                });
              }),
          // button save
          const SizedBox(height: 70),
          SaveButton(
            onTap: () async {
              // Validasi input
              if (!isInputValid()) {
                showInvalidResponse();
                return;
              }

              // Mendapatkan koneksi database
              final sqlite = SQLite.getInstance();
              final db = await sqlite.database;

              // Menyimpan data
              await sqlite.expenseRepository.insert(db, {
                'title': titleController.value.text,
                'category': selectedCategory,
                'amount': amountController.value.text,
                'date': expenseDate,
              });

              showSuccessResponse();
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
