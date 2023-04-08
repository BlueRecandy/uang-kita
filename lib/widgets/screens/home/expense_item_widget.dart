import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:uang_kita/models/category_type_model.dart';
import 'package:uang_kita/utils/string_utils.dart';

import '../../../models/expense_model.dart';

class ExpenseItemWidget extends StatelessWidget {
  const ExpenseItemWidget({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              expense.category.displayName,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        Text(
          'Rp. ${StringUtils.formattedMoney(expense.amount, true)}',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
