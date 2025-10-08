enum ReservationStatus { pending, confirmed, cancelled, completed }

class Reservation {
  final String id;
  final String userId;
  final String productId;
  final String productName;
  final int quantity;
  final DateTime reservationDate;
  final DateTime pickupDate;
  final ReservationStatus status;
  final String? notes;

  Reservation({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.reservationDate,
    required this.pickupDate,
    required this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'reservationDate': reservationDate.toIso8601String(),
      'pickupDate': pickupDate.toIso8601String(),
      'status': status.toString(),
      'notes': notes,
    };
  }

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      userId: json['userId'],
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      reservationDate: DateTime.parse(json['reservationDate']),
      pickupDate: DateTime.parse(json['pickupDate']),
      status: ReservationStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => ReservationStatus.pending,
      ),
      notes: json['notes'],
    );
  }
}
