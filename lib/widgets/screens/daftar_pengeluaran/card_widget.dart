import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uang_kita/utils/string_utils.dart';
import 'package:uang_kita/utils/uang_kita_date_utils.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key, required this.expense, required this.currentPeriod});

  final int expense;
  final DateTimeRange currentPeriod;

  @override
  Widget build(BuildContext context) {
    final startMonthNumber = currentPeriod.start.month;
    final startYear = currentPeriod.start.year;
    final endMonthNumber = currentPeriod.end.month;
    final endYear = currentPeriod.end.year;
    final isMonthNumberSame = startMonthNumber == currentPeriod.end.month;

    return Container(
      width: 84.w,
      height: 22.h,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengeluaran bulan',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.white),
          ),
          Padding(padding: EdgeInsets.only(bottom: 1.h)),
          Text(
            isMonthNumberSame
                ? '${UangKitaDateUtils.monthNumberToString(endMonthNumber)} $endYear'
                : '${UangKitaDateUtils.monthNumberToString(startMonthNumber)} $startYear - ${UangKitaDateUtils.monthNumberToString(endMonthNumber)} $endYear',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Padding(padding: EdgeInsets.only(bottom: 3.h)),
          Text(
            'Rp. ${StringUtils.formattedMoney(expense)}',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }
}
