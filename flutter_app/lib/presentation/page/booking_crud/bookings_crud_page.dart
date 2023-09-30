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

class BookingCrudPage extends StatefulWidget {
  static const String route = "BookingCrudPage";
  final BookingCrudModel model;

  const BookingCrudPage({required this.model});

  @override
  State<BookingCrudPage> createState() => _BookingCrudPageState();
}

class _BookingCrudPageState extends State<BookingCrudPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CalculatorBloc>(context).add(InitCalculatorEvent());
    BlocProvider.of<BookingCrudBloc>(context).add(InitBookingCrudEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _openCategories() {
    _animateToPage(1);
  }

  _animateToPage(int page) {
    _currentPage = page;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  _upload() {
    BlocProvider.of<BookingCrudBloc>(context).add(UploadBookingCrudEvent(widget.model));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentPage > 0) {
          _animateToPage(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isCreating() ? "create booking" : "edit booking"),
        ),
        body: BlocConsumer<BookingCrudBloc, BookingCrudState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is BookingCrudInitState) {
              return _buildView(widget.model);
            }
            if (state is BookingCrudErrorState) {
              return ErrorText(message: state.message, onReload: _upload);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
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
          DateInput(model: model),
          AmountDisplay(),
          DescriptionInput(model: model),
          Expanded(child: _buildPageView()),
        ],
      ),
    );
  }

  _buildPageView() {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        _buildCalculatorView(),
        _buildCategoriesView(),
      ],
    );
  }

  _buildCalculatorView() {
    return Column(
      children: [
        const Spacer(),
        Calculator(model: widget.model),
        ChooseCategoryButton(model: widget.model, onPressed: _openCategories),
      ],
    );
  }

  _buildCategoriesView() {
    return Container(color: Colors.red);
  }

  bool _isCreating() {
    return widget.model.model.id == null;
  }
}
