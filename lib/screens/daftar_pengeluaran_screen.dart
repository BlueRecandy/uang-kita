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
    _loadExpense();
  }

  Future<void> _loadExpense() async {
    final expenses = await _retrieveExpenses(currentDateRange);

    setState(() {
      expenseList.clear();
      expenseList.addAll(expenses);

      monthlyExpense = _calculateCurrentMonthExpense(expenses);
    });
  }

  int _calculateCurrentMonthExpense(List<Expense> expenses) {
    final int currentMonthExpense = -expenses.fold<int>(
        0, (previousValue, element) => previousValue + element.amount);

    return currentMonthExpense;
  }

  Future<List<Expense>> _retrieveExpenses(DateTimeRange rangeTime) async {
    final sqlite = SQLite.getInstance();
    final db = await sqlite.database;

    final expenses =
        await sqlite.expenseRepository.findInDateRange(db, rangeTime);

    return expenses;
  }

  void _showExpensePeriodDialog() async {
    final currentDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final firstDate = currentDate.subtract(const Duration(days: 365));
    final lastDate =
        currentDate.add(const Duration(hours: 23, minutes: 59, seconds: 59));

    final selectedRange = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: currentDateRange,
    );

    if (selectedRange == null) {
      return;
    }

    final dateRange = DateTimeRange(
        start: selectedRange.start,
        end: selectedRange.end
            .add(const Duration(hours: 23, minutes: 59, seconds: 59)));

    setState(() {
      currentDateRange = dateRange;
    });

    await _loadExpense();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardWidget(
              expense: monthlyExpense,
              currentPeriod: currentDateRange,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 2.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtonWidget(
                      icon: HeroIcons.calendar,
                      onPressed: _showExpensePeriodDialog),
                  IconButtonWidget(
                      icon: HeroIcons.plus,
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) =>
                                    const TambahPengeluaranScreen()))
                            .then((value) {
                          _loadExpense();
                        });
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
