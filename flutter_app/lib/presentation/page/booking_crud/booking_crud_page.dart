import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/app_dimensions.dart';
import 'package:flutter_app/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'booking_crud_tab1.dart';
import 'booking_crud_tab2.dart';
import 'widget/category_type_button.dart';

class BookingCrudPage extends StatefulWidget {
  static const String route = "BookingCrudPage";
  final BookingModel model;

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
    BlocProvider.of<CategoryListBloc>(context).add(LoadCategoryListEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _openCategories() {
    if (widget.model.amount! > 0) {
      _animateToPage(1);
    }
  }

  _animateToPage(int page) {
    setState(() {
      _currentPage = page;
    });

    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  _upload() {
    BlocProvider.of<BookingCrudBloc>(context).add(UploadBookingCrudEvent(widget.model));
  }

  _onUploadSuccess() {
    BlocProvider.of<GraphViewBloc>(context).add(RefreshGraphViewEvent());
    Navigator.of(context).pop();
  }

  _onCategoryPressed(CategoryType categoryType) {
    setState(() {
      widget.model.categoryType = categoryType;
    });
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
          title: Text(_isCreating() ? "New" : "Edit"),
          actions: [
            CategoryTypeButton(model: widget.model, categoryType: CategoryType.outcome, onPressed: _onCategoryPressed),
            CategoryTypeButton(model: widget.model, categoryType: CategoryType.income, onPressed: _onCategoryPressed),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<BookingCrudBloc, BookingCrudState>(
          listener: (context, state) {
            if (state is BookingCrudUploadedState) {
              _onUploadSuccess();
            }
          },
          builder: (context, state) {
            if (state is BookingCrudInitState) {
              return _buildView();
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

  Widget _buildView() {
    return SafeArea(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            BookingCrudTab1(model: widget.model, onCategoryTap: _openCategories),
            BookingCrudTab2(model: widget.model, onUpload: _upload),
          ],
        ),
      ),
    );
  }

  bool _isCreating() {
    return widget.model.id == null;
  }
}
