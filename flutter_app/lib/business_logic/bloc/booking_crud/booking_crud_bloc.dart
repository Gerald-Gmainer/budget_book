import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_crud_event.dart';
part 'booking_crud_state.dart';

class BookingCrudBloc extends Bloc<BookingCrudEvent, BookingCrudState> {
  final BookingRepository bookingRepo;

  BookingCrudBloc(this.bookingRepo) : super(BookingCrudInitState()) {
    on<InitBookingCrudEvent>(_onInitBookingCrudEvent);
    on<UploadBookingCrudEvent>(_onUploadBookingCrudEvent);
  }

  _onInitBookingCrudEvent(InitBookingCrudEvent event, Emitter<BookingCrudState> emit) async {
    emit(BookingCrudInitState());
  }

  _onUploadBookingCrudEvent(UploadBookingCrudEvent event, Emitter<BookingCrudState> emit) async {
    BudgetLogger.instance.d(event.model);
  }
}
