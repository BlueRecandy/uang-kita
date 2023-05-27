import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';
import 'package:uang_kita/db/sqlite.dart';
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
  final List<Expense> expenseList = [];
  int monthlyExpense = 0;

  DateTime now = DateTime.now();
  DateTimeRange currentDateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime.now());

  @override
  void initState() {
    super.initState();

    loadExpense();
  }

  Future<void> loadExpense() async {
    final sqlite = SQLite.getInstance();
    final db = await sqlite.database;

    final currentMonthRange = DateTimeRange(
        start: DateTime(now.year, now.month, 1),
        end: DateTime(now.year, now.month + 1, 0));

    final expenses =
        await sqlite.expenseRepository.findInDateRange(db, currentMonthRange);

    final int currentMonthExpense = -expenses.fold<int>(
        0, (previousValue, element) => previousValue + element.amount);

    setState(() {
      expenseList.clear();
      expenseList.addAll(expenses);

      monthlyExpense = currentMonthExpense;
    });
  }

  void showExpensePeriodDialog() async {
    final dateRange = await showDateRangePicker(
      context: context,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now,
      initialDateRange: currentDateRange,
    );

    if (dateRange == null) {
      return;
    }

    setState(() {
      currentDateRange = dateRange;
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
            CardWidget(expense: monthlyExpense),
            Padding(
              padding: EdgeInsets.only(
                top: 2.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtonWidget(
                      icon: HeroIcons.calendar,
                      onPressed: showExpensePeriodDialog),
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
