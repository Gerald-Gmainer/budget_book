part of 'booking_crud_bloc.dart';

@immutable
abstract class BookingCrudEvent {}

class LoadBookingCrudEvent extends BookingCrudEvent {
  final BookingModel model;

  LoadBookingCrudEvent(this.model);
}

class UploadBookingCrudEvent extends BookingCrudEvent {
  final BookingModel model;

  UploadBookingCrudEvent(this.model);
}


