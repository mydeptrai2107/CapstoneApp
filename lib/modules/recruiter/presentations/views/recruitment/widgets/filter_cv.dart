import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:flutter/material.dart';

class FilterCv extends StatefulWidget {
  const FilterCv({super.key});

  @override
  State<FilterCv> createState() => _FilterCvState();
}

class _FilterCvState extends State<FilterCv> {
  final list = ['Tất cả', 'Đang hiển thị', 'Tin bị khóa'];
  int? _selectItem = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(list.length, (index) {
        final item = list[index];
        final isSelect = _selectItem == index;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(item),
            selectedColor: primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            labelStyle:
                TextStyle(color: isSelect ? Colors.white : Colors.black),
            surfaceTintColor: Colors.white,
            selected: isSelect,
            onSelected: (value) => setState(() {
              _selectItem = value ? index : null;
            }),
          ),
        );
      }),
    );
  }
}
