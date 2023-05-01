import 'package:flutter/material.dart';

class TagihanItemWidget extends StatelessWidget {
  const TagihanItemWidget(
      {super.key,
      required this.price,
      required this.title,
      required this.description});

  final int price;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        description,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 0, 0, 0)),
        ),
        onPressed: () {},
        child: Text(
          'Rp. $price',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      isThreeLine: true,
      onTap: () {
        print("On Tap is fired");
      },
    );
  }
}
