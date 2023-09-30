part of 'booking_crud_bloc.dart';

@immutable
abstract class BookingCrudEvent {}

class InitBookingCrudEvent extends BookingCrudEvent {}

class UploadBookingCrudEvent extends BookingCrudEvent {
  final BookingCrudModel model;

  UploadBookingCrudEvent(this.model);
}
