import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'booking_crud_tab1.dart';
import 'booking_crud_tab2.dart';
import 'widget/amount_display.dart';
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
  final GlobalKey<AmountDisplayState> _amountDisplayKey = GlobalKey<AmountDisplayState>();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CalculatorBloc>(context).add(InitCalculatorEvent(widget.model.amount));
    BlocProvider.of<BookingCrudBloc>(context).add(InitBookingCrudEvent());
    BlocProvider.of<CategoryListBloc>(context).add(LoadCategoryListEvent());
    BlocProvider.of<SuggestionBloc>(context).add(LoadSuggestionEvent());
    if (_isCreating()) {
      _setDefaultAccount();
    }
  }

  _setDefaultAccount() {
    final state = BlocProvider.of<GraphViewBloc>(context).state;
    if (state is GraphViewLoadedState) {
      setState(() {
        widget.model.account = state.bookModel.accounts[0];
      });
    } else {
      BudgetLogger.instance.i("could not set default account");
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _openCategories() {
    if (widget.model.amount! > 0) {
      _animateToPage(1);
    } else {
      _amountDisplayKey.currentState?.triggerShakeAnimation();
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
    if (widget.model.category == null) {
      showErrorSnackBar(context, "Please select a category", duration: Duration(seconds: 2));
      return;
    }
    BlocProvider.of<BookingCrudBloc>(context).add(UploadBookingCrudEvent(widget.model));
  }

  _onUploadSuccess() {
    BlocProvider.of<GraphViewBloc>(context).add(RefreshGraphViewEvent());
    BlocProvider.of<SuggestionBloc>(context).add(LoadSuggestionEvent(forceReload: true));
    Navigator.of(context).pop();
  }

  _onCategoryTypePressed(CategoryType categoryType) {
    setState(() {
      widget.model.categoryType = categoryType;
    });
  }

  _onDelete() {
    ConfirmDialog.show(
      context,
      headerText: "Delete",
      bodyText: "Do you want to delete this booking?",
      onOK: _deleteBooking,
    );
  }

  _deleteBooking() {
    BlocProvider.of<BookingCrudBloc>(context).add(DeleteBookingCrudEvent(widget.model));
  }

  _onDeleteSuccess() {
    BlocProvider.of<GraphViewBloc>(context).add(RefreshGraphViewEvent());
    Navigator.of(context).pop();
    BlocProvider.of<SuggestionBloc>(context).add(LoadSuggestionEvent(forceReload: true));
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
            CategoryTypeButton(model: widget.model, categoryType: CategoryType.outcome, onPressed: _onCategoryTypePressed),
            CategoryTypeButton(model: widget.model, categoryType: CategoryType.income, onPressed: _onCategoryTypePressed),
            if (!_isCreating()) _buildDeleteButton(),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<BookingCrudBloc, BookingCrudState>(
          listener: (context, state) {
            if (state is BookingCrudUploadedState) {
              _onUploadSuccess();
            } else if (state is BookingCrudDeletedState) {
              _onDeleteSuccess();
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
            BookingCrudTab1(model: widget.model, onCategoryTap: _openCategories, amountDisplayKey: _amountDisplayKey),
            BookingCrudTab2(model: widget.model, onUpload: _upload),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: _onDelete,
    );
  }

  bool _isCreating() {
    return widget.model.id == null;
  }
}
