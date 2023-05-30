import 'package:flutter/material.dart';
import 'package:uang_kita/models/bill_model.dart';

class TagihanItemWidget extends StatelessWidget {
  const TagihanItemWidget({super.key, required this.tagihan});

  final Bill tagihan;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        tagihan.title,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 0, 0, 0)),
        ),
        onPressed: () {},
        child: Text(
          'Rp. ${tagihan.amount}',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      onTap: () {
        print("On Tap is fired");
      },
    );
  }
}
