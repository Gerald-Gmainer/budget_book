import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_crud_event.dart';
part 'booking_crud_state.dart';

class BookingCrudBloc extends Bloc<BookingCrudEvent, BookingCrudState> {
  final BookingRepository bookingRepo;

  BookingCrudBloc(this.bookingRepo) : super(BookingCrudInitState()) {
    on<LoadBookingCrudEvent>(_onLoadBookingCrudEvent);
    on<UploadBookingCrudEvent>(_onUploadBookingCrudEvent);
  }

  _onLoadBookingCrudEvent(LoadBookingCrudEvent event, Emitter<BookingCrudState> emit) async {
    emit(BookingCrudLoadedState(event.model));
  }

  _onUploadBookingCrudEvent(UploadBookingCrudEvent event, Emitter<BookingCrudState> emit) async {}
}
