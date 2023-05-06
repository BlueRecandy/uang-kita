import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uang_kita/utils/string_utils.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.expense});

  final int expense;

  @override
  Widget build(BuildContext context) {
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
            'Pengeluaran bulan ini',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.white),
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
