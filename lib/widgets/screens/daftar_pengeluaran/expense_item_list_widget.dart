import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uang_kita/models/expense_model.dart';
import 'package:uang_kita/widgets/screens/daftar_pengeluaran/expense_item_widget.dart';

class ExpenseItemListWidget extends StatefulWidget {
  const ExpenseItemListWidget({super.key, required this.expenseList});

  final List<Expense> expenseList;

  @override
  State<StatefulWidget> createState() => _ExpenseItemListWidgetState();
}

class _ExpenseItemListWidgetState extends State<ExpenseItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.h),
      child: widget.expenseList.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tidak ada data pengeluaran',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ))
          : ListView.separated(
              itemBuilder: (context, index) {
                final expense = widget.expenseList[index];
                return ExpenseItemWidget(expense: expense);
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: widget.expenseList.length),
    );
  }
}
