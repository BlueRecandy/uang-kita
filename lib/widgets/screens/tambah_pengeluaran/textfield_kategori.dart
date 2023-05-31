import 'package:flutter/material.dart';

import '../../../models/category_type_model.dart';

class DropdownCategoryItems extends StatefulWidget {
  final List<CategoryTypeModel> items;
  final String hint;
  final Function(String?) onChanged;

  const DropdownCategoryItems({
    Key? key,
    required this.items,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownCategoryItems> createState() => _DropdownCategoryItemsState();
}

class _DropdownCategoryItemsState extends State<DropdownCategoryItems> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: const Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButtonFormField<String>(
          value: selectedItem,
          onChanged: widget.onChanged,
          items: widget.items
              .map((e) => DropdownMenuItem(
                    value: e.type.displayName,
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: e.icon,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            e.type.displayName,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => widget.items
              .map((e) => Row(
                    children: [
                      SizedBox(
                        width: 42,
                        child: e.icon,
                      ),
                      const SizedBox(width: 5),
                      Text(e.type.displayName)
                    ],
                  ))
              .toList(),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
        ),
      ),
    );
  }
}
