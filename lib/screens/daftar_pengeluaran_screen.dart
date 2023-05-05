import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';
import 'package:uang_kita/db/sqlite.dart';
import 'package:uang_kita/models/category_type_model.dart';
import 'package:uang_kita/models/expense_model.dart';
import 'package:uang_kita/screens/tambah_pengeluaran_screen.dart';
import 'package:uang_kita/widgets/icon_button_widget.dart';
import 'package:uang_kita/widgets/screens/daftar_pengeluaran/card_widget.dart';
import 'package:uang_kita/widgets/screens/daftar_pengeluaran/expense_item_list_widget.dart';

class DaftarPengeluaranScreen extends StatefulWidget {
  const DaftarPengeluaranScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DaftarPengeluaranScreenState();
}

class _DaftarPengeluaranScreenState extends State<DaftarPengeluaranScreen> {
  final expenseList = [
    Expense(
        id: 1,
        title: 'Nasi Kuning',
        amount: 10000,
        date: DateTime.now(),
        category: CategoryType.foodAndDrink),
    Expense(
        id: 2,
        title: 'Laundry',
        amount: 22000,
        date: DateTime.now(),
        category: CategoryType.dailyNeeds),
  ];

  @override
  void initState() {
    super.initState();

    // TODO read data from database
    loadExpense();
  }

  Future<void> loadExpense() async {
    final sqlite = SQLite.getInstance();

    final expenses =
        await sqlite.expenseRepository.findAll(await sqlite.database);

    setState(() {
      expenseList.clear();
      expenseList.addAll(expenses);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CardWidget(expense: 5000000),
            Padding(
              padding: EdgeInsets.only(
                top: 2.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtonWidget(
                      icon: HeroIcons.bars3BottomLeft, onPressed: () {}),
                  IconButtonWidget(
                      icon: HeroIcons.plus,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const TambahPengeluaranScreen()));
                      })
                ],
              ),
            ),
            Expanded(child: ExpenseItemListWidget(expenseList: expenseList))
          ],
        ),
      ),
    );
  }
}
