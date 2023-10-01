import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/app_dimensions.dart';

class DescriptionInput extends StatelessWidget {
  final BookingCrudModel model;

  const DescriptionInput({required this.model});

  _onChanged(String value) {
    model.bookingModel.description = value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding, vertical: 0),
      child: TextFormField(
        onChanged: _onChanged,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.edit),
          labelText: 'Note',
        ),
      ),
    );
  }
}
