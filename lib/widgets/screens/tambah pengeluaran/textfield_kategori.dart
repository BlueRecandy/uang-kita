import 'package:flutter/material.dart';

import '../../../models/category_type_model.dart';

class CustomDropdown extends StatefulWidget {
  final List<CategoryTypeModel> items;
  final String hint;
  final Function(String?) onChanged;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
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
            color: Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedItem,
          onChanged: widget.onChanged,
          items: widget.items
              .map((e) => DropdownMenuItem(
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: e.icon,
                          ),
                          SizedBox(width: 10),
                          Text(
                            e.type.displayName,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e.type.displayName,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => widget.items
              .map((e) => Row(
                    children: [
                      Container(
                        width: 42,
                        child: e.icon,
                      ),
                      SizedBox(width: 5),
                      Text(e.type.displayName)
                    ],
                  ))
              .toList(),
          hint: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              widget.hint,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }
}
