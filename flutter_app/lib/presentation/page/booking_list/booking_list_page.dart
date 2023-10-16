import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/category_type.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

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
  CategoryBookingGroupModel? get categoryGroupModel => widget.pageModel.categoryGroupModel;
  List<BookingModel>? get bookings => widget.pageModel.bookings;
  Map<DateTime, List<BookingModel>> _groupedBookings = {};

  @override
  void initState() {
    super.initState();
    _groupBookings();
  }

  _groupBookings() {
    List<BookingModel> items = _prepareBookings();
    final grouped = groupBy(items, (booking) {
      final date = booking.bookingDate;
      if (date != null) {
        return DateTime(date.year, date.month, date.day);
      }
      return null;
    });

    final result = Map<DateTime, List<BookingModel>>.fromEntries(
      grouped.entries.map((entry) => MapEntry(entry.key!, entry.value)),
    );

    setState(() {
      _groupedBookings = result;
    });
  }

  List<BookingModel> _prepareBookings() {
    List<BookingModel> items = [];
    if (categoryGroupModel != null) {
      items = categoryGroupModel!.bookings;
    } else if (bookings != null) {
      items = bookings!;
    }
    items.sort((a, b) => (b.bookingDate ?? DateTime(0)).compareTo(a.bookingDate ?? DateTime(0)));
    return items;
  }

  _createBooking() {
    BookingModel booking = BookingModel.empty();
    if (categoryGroupModel != null) {
      booking.categoryType = categoryGroupModel!.category.categoryType;
      booking.category = categoryGroupModel!.category;
    }
    Navigator.of(context).pushNamed(BookingCrudPage.route, arguments: booking);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getAppBarText(),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppDimensions.pagePadding,
          child: _buildList(_groupedBookings),
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
    if (categoryGroupModel != null) {
      final String categoryName = categoryGroupModel!.category.name ?? "Unknown";
      return Row(
        children: [
          Text(categoryName),
          SizedBox(width: 8),
          CurrencyText(
            value: categoryGroupModel!.amount,
            style: TextStyle(fontSize: 20, color: categoryGroupModel!.category.categoryType.color),
          )
        ],
      );
    }
    if (bookings != null) {
      return Text("Bookings");
    }
    return Text("Unknown");
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
