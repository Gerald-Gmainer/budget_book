import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';

class DescriptionInput extends StatelessWidget {
  final BookingModel model;
  final TextEditingController controller;

  DescriptionInput({required this.model}): controller = TextEditingController(text: model.dataModel.description);

  _onChanged(String value) {
    model.dataModel.description = value;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: _onChanged,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.edit),
        labelText: 'Note',
      ),
    );
  }
}
