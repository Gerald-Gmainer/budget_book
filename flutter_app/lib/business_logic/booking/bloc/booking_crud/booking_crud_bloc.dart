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
  final BookingConverter _converter = BookingConverter();

  BookingCrudBloc(this.bookingRepo) : super(BookingCrudInitState()) {
    on<InitBookingCrudEvent>(_onInitBookingCrudEvent);
    on<UploadBookingCrudEvent>(_onUploadBookingCrudEvent);
    on<DeleteBookingCrudEvent>(_onDeleteBookingCrudEvent);
  }

  _onInitBookingCrudEvent(InitBookingCrudEvent event, Emitter<BookingCrudState> emit) async {
    emit(BookingCrudInitState());
  }

  _onUploadBookingCrudEvent(UploadBookingCrudEvent event, Emitter<BookingCrudState> emit) async {
    try {
      emit(BookingCrudLoadingState());
      final model = _converter.toDataModel(event.model);
      if (model.id == null) {
        await bookingRepo.createBooking(model);
      } else {
        await bookingRepo.updateBooking(model);
      }
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

  _onDeleteBookingCrudEvent(DeleteBookingCrudEvent event, Emitter<BookingCrudState> emit) async {
    try {
      emit(BookingCrudLoadingState());
      if (event.model.id == null) {
        throw "Cannot delete booking because ID is NULL";
      }
      await bookingRepo.deleteBooking(event.model.id!);
      emit(BookingCrudDeletedState());
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(BookingCrudErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(BookingCrudErrorState("An error happened. Please try again"));
      }
    }
  }
}
