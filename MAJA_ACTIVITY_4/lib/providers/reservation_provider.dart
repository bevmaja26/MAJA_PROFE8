import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/reservation_model.dart';

class ReservationProvider with ChangeNotifier {
  List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

  Future<void> loadReservations(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final reservationsJson = prefs.getStringList('reservations_$userId') ?? [];

    _reservations = reservationsJson
        .map((json) => Reservation.fromJson(jsonDecode(json)))
        .toList();

    notifyListeners();
  }

  Future<Reservation> createReservation({
    required String userId,
    required String productId,
    required String productName,
    required int quantity,
    required DateTime pickupDate,
    String? notes,
  }) async {
    final reservation = Reservation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      productId: productId,
      productName: productName,
      quantity: quantity,
      reservationDate: DateTime.now(),
      pickupDate: pickupDate,
      status: ReservationStatus.pending,
      notes: notes,
    );

    _reservations.insert(0, reservation);
    await _saveReservations(userId);
    notifyListeners();

    return reservation;
  }

  Future<void> updateReservationStatus(
    String reservationId,
    ReservationStatus status,
  ) async {
    final index = _reservations.indexWhere((r) => r.id == reservationId);
    if (index >= 0) {
      final reservation = _reservations[index];
      _reservations[index] = Reservation(
        id: reservation.id,
        userId: reservation.userId,
        productId: reservation.productId,
        productName: reservation.productName,
        quantity: reservation.quantity,
        reservationDate: reservation.reservationDate,
        pickupDate: reservation.pickupDate,
        status: status,
        notes: reservation.notes,
      );

      await _saveReservations(reservation.userId);
      notifyListeners();
    }
  }

  Future<void> cancelReservation(String reservationId) async {
    await updateReservationStatus(reservationId, ReservationStatus.cancelled);
  }

  Future<void> _saveReservations(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final reservationsJson = _reservations
        .where((r) => r.userId == userId)
        .map((r) => jsonEncode(r.toJson()))
        .toList();

    await prefs.setStringList('reservations_$userId', reservationsJson);
  }

  List<Reservation> getReservationsByStatus(ReservationStatus status) {
    return _reservations.where((r) => r.status == status).toList();
  }

  List<Reservation> getUpcomingReservations() {
    final now = DateTime.now();
    return _reservations
        .where((r) =>
            r.pickupDate.isAfter(now) &&
            r.status == ReservationStatus.confirmed)
        .toList();
  }
}
