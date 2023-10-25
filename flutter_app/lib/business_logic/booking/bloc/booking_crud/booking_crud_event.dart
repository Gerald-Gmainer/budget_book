part of 'booking_crud_bloc.dart';

@immutable
abstract class BookingCrudEvent {}

class InitBookingCrudEvent extends BookingCrudEvent {}

class UploadBookingCrudEvent extends BookingCrudEvent {
  final BookingModel model;

  UploadBookingCrudEvent(this.model);
}

class DeleteBookingCrudEvent extends BookingCrudEvent {
  final BookingModel model;

  DeleteBookingCrudEvent(this.model);
}
