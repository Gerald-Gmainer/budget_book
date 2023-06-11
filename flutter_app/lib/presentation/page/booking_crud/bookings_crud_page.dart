import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingCrudPage extends StatefulWidget {
  static const String route = "BookingCrudPage";
  final BookingCrudModel model;

  const BookingCrudPage({required this.model});

  @override
  State<BookingCrudPage> createState() => _BookingCrudPageState();
}

class _BookingCrudPageState extends State<BookingCrudPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreating() ? "create booking" : "edit booking"),
      ),
      body: BlocConsumer<BookingCrudBloc, BookingCrudState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }

  bool _isCreating() {
    return widget.model.model.id == null;
  }
}
