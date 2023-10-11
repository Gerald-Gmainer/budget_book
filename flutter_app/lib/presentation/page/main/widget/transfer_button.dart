import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';

class TransferButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigator.of(context).pushNamed(BookingCrudPage.route, arguments: BookingModel.empty());
      },
      child: const Icon(Icons.swap_horiz),
    );
  }

}