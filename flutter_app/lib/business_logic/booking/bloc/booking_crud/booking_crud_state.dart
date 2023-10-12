part of 'booking_crud_bloc.dart';

@immutable
abstract class BookingCrudState {}

class BookingCrudInitState extends BookingCrudState {}

class BookingCrudLoadingState extends BookingCrudState {}

class BookingCrudUploadedState extends BookingCrudState {}

class BookingCrudErrorState extends BookingCrudState {
  final String message;

  BookingCrudErrorState(this.message);
}
