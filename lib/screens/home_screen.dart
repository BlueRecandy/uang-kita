import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:uang_kita/models/category_type_model.dart';
import 'package:uang_kita/models/expense_model.dart';
import 'package:uang_kita/widgets/screens/home/card_widget.dart';
import 'package:uang_kita/widgets/screens/home/expense_item_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardWidget(expense: 5000000),
          Expanded(child: ExpenseItemListWidget(expenseList: expenseList))
        ],
      ),
    );
  }
}