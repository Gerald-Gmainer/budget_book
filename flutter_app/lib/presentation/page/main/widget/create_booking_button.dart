import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';

class CreateBookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(BookingCrudPage.route, arguments: BookingModel.empty());
      },
      child: const Icon(Icons.add),
    );
  }

}