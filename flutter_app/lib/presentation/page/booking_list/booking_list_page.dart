import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getAppBarText(),
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
            style: TextStyle(fontSize: 20),
          )
        ],
      );
    }
    if (bookings != null) {
      return Text("Bookings");
    }
    return Text("Unknown");
  }
}
