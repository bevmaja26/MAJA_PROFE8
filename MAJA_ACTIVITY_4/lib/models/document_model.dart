enum DocumentType { receipt, purchaseOrder, invoice, deliveryNote, other }

enum DocumentStatus { pending, approved, rejected }

class Document {
  final String id;
  final String userId;
  final String orderId;
  final DocumentType type;
  final DocumentStatus status;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Document({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.type,
    required this.status,
    required this.title,
    this.description,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'orderId': orderId,
      'type': type.toString(),
      'status': status.toString(),
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      userId: json['userId'],
      orderId: json['orderId'],
      type: DocumentType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => DocumentType.other,
      ),
      status: DocumentStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => DocumentStatus.pending,
      ),
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
