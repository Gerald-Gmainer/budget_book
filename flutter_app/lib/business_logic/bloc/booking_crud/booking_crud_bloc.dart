import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';
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
    try {
      BudgetLogger.instance.d("upload ${event.model.dataModel.toJson()}");
      emit(BookingCrudLoadingState());
      await bookingRepo.uploadBooking(event.model.dataModel);
      emit(BookingCrudUploadedState());
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(BookingCrudErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(BookingCrudErrorState(e.toString()));
      }
    }
  }
}
