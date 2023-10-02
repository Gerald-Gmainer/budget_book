import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';

class DescriptionInput extends StatelessWidget {
  final BookingCrudModel model;
  final TextEditingController controller;

  DescriptionInput({required this.model}): controller = TextEditingController(text: model.bookingModel.description);

  _onChanged(String value) {
    model.bookingModel.description = value;
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
