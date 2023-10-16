import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class BookingListItem extends StatelessWidget {
  final BookingModel booking;

  const BookingListItem({required this.booking});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        IconConverter.getIconFromModel(booking.category?.iconData),
        color: ColorConverter.iconColorToColor(booking.category?.iconColor),
        size: 26,
      ),
      title: Text(
        booking.category?.name ?? "Unknown",
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
      ),
      subtitle: Text(booking.description ?? ''),
      trailing: CurrencyText(
        value: booking.amount,
        style: TextStyle(
          color: booking.categoryType.color,
          fontSize: 16,
        ),
      ),
      dense: true,
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.only(right: AppDimensions.horizontalPadding / 2),
    );
  }
}
