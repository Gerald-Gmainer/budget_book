import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/category_type.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/booking_list_date.dart';
import 'widget/booking_list_item.dart';

export 'booking_list_page_model.dart';

class BookingListPage extends StatefulWidget {
  static const String route = "BookingListPage";

  final BookingListPageModel pageModel;

  const BookingListPage({required this.pageModel});

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  late CategoryBookingGroupModel _categoryBookingGroupModel;
  Map<DateTime, List<BookingModel>> _groupedBookings = {};

  @override
  void initState() {
    super.initState();
    _initBookings(widget.pageModel.categoryGroupModel);
  }

  _initBookings(CategoryBookingGroupModel groupModel) {
    setState(() {
      _categoryBookingGroupModel = groupModel;
    });
    final grouped = _groupBookings(groupModel.bookings);
    final result = Map<DateTime, List<BookingModel>>.fromEntries(
      grouped.entries.map((entry) => MapEntry(entry.key!, entry.value)),
    );

    setState(() {
      _groupedBookings = result;
    });
  }

  Map<DateTime?, List<BookingModel>> _groupBookings(List<BookingModel> bookings) {
    bookings.sort((a, b) => (b.bookingDate ?? DateTime(0)).compareTo(a.bookingDate ?? DateTime(0)));
    final Map<DateTime?, List<BookingModel>> grouped = groupBy(bookings, (booking) {
      final date = booking.bookingDate;
      if (date != null) {
        return DateTime(date.year, date.month, date.day);
      }
      return null;
    });
    return grouped;
  }

  _createBooking() {
    BookingModel booking = BookingModel.empty();
    booking.categoryType = _categoryBookingGroupModel.category.categoryType;
    booking.category = _categoryBookingGroupModel.category;
    Navigator.of(context).pushNamed(BookingCrudPage.route, arguments: booking);
  }

  _reloadBookings(BudgetBookModel bookModel) {
    for (BudgetPeriodModel periodModel in bookModel.periodModels) {
      if (periodModel.periodFilter != widget.pageModel.periodFilter) {
        continue;
      }

      var foundModel = periodModel.categoryBookingGroupModels.firstWhereOrNull((e) => e == widget.pageModel.categoryGroupModel);
      if (foundModel != null) {
        setState(() {
          _initBookings(foundModel!);
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getAppBarText(),
      ),
      body: BlocListener<GraphViewBloc, GraphViewState>(
        listener: (context, state) {
          if (state is GraphViewLoadedState) {
            _reloadBookings(state.bookModel);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: AppDimensions.pagePadding,
            child: _buildList(_groupedBookings),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "CreateBookingButton",
        onPressed: () {
          _createBooking();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getAppBarText() {
    return Row(
      children: [
        Text(_categoryBookingGroupModel.category.name ?? "Unknown"),
        SizedBox(width: 8),
        CurrencyText(
          value: _categoryBookingGroupModel.amount,
          style: TextStyle(fontSize: 20, color: _categoryBookingGroupModel.category.categoryType.color),
        )
      ],
    );
  }

  Widget _buildList(Map<DateTime, List<BookingModel>> groupedBookings) {
    return ListView.builder(
      itemCount: groupedBookings.length,
      itemBuilder: (context, index) {
        final date = groupedBookings.keys.elementAt(index);
        final bookings = groupedBookings[date];
        List<Widget> bookingWidgets = [];

        bookingWidgets.add(BookingListDate(date: date));
        if (bookings != null) {
          for (var booking in bookings) {
            bookingWidgets.add(BookingListItem(booking: booking));
          }
          bookingWidgets.add(Divider());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bookingWidgets,
        );
      },
    );
  }
}
