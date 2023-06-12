import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/amount_display.dart';
import 'widget/choose_category_button.dart';
import 'widget/date_input.dart';
import 'widget/description_input.dart';
import 'widget/number_input.dart';

class BookingCrudPage extends StatefulWidget {
  static const String route = "BookingCrudPage";
  final BookingCrudModel model;

  const BookingCrudPage({required this.model});

  @override
  State<BookingCrudPage> createState() => _BookingCrudPageState();
}

class _BookingCrudPageState extends State<BookingCrudPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() {
    BlocProvider.of<BookingCrudBloc>(context).add(LoadBookingCrudEvent(widget.model));
  }

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
          if (state is BookingCrudLoadedState) {
            return _buildView(state.model);
          }
          if (state is BookingCrudErrorState) {
            return ErrorText(message: state.message, onReload: _load);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildView(BookingCrudModel model) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.verticalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DateInput(),
          AmountDisplay(),
          DescriptionInput(),
          const Spacer(),
          NumberInput(),
          ChooseCategoryButton(),
        ],
      ),
    );
  }

  bool _isCreating() {
    return widget.model.model.id == null;
  }
}
