import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';

class CategoryTypeRadio extends StatelessWidget {
  final String text;
  final CategoryType selectedType;
  final Function(CategoryType type) onTypeChange;
  final CategoryType value;

  const CategoryTypeRadio({
    required this.text,
    required this.selectedType,
    required this.onTypeChange,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 0,
        title: Text(text),
        leading: Radio(
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: value,
          groupValue: selectedType,
          onChanged: (CategoryType? value) {
            if (value != null) {
              onTypeChange.call(value!);
            }
          },
        ),
      ),
    );
  }
}
