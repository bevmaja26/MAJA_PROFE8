import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/document_model.dart';

class DocumentProvider with ChangeNotifier {
  List<Document> _documents = [];

  List<Document> get documents => _documents;

  Future<void> loadDocuments(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final documentsJson = prefs.getStringList('documents_$userId') ?? [];

    _documents = documentsJson
        .map((json) => Document.fromJson(jsonDecode(json)))
        .toList();

    notifyListeners();
  }

  Future<Document> createDocument({
    required String userId,
    required String orderId,
    required DocumentType type,
    required String title,
    String? description,
  }) async {
    final document = Document(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      orderId: orderId,
      type: type,
      status: DocumentStatus.pending,
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );

    _documents.insert(0, document);
    await _saveDocuments(userId);
    notifyListeners();

    return document;
  }

  Future<void> updateDocumentStatus(
    String documentId,
    DocumentStatus status,
  ) async {
    final index = _documents.indexWhere((d) => d.id == documentId);
    if (index >= 0) {
      final document = _documents[index];
      _documents[index] = Document(
        id: document.id,
        userId: document.userId,
        orderId: document.orderId,
        type: document.type,
        status: status,
        title: document.title,
        description: document.description,
        createdAt: document.createdAt,
        updatedAt: DateTime.now(),
      );

      await _saveDocuments(document.userId);
      notifyListeners();
    }
  }

  Future<void> _saveDocuments(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final documentsJson = _documents
        .where((d) => d.userId == userId)
        .map((d) => jsonEncode(d.toJson()))
        .toList();

    await prefs.setStringList('documents_$userId', documentsJson);
  }

  List<Document> getDocumentsByType(DocumentType type) {
    return _documents.where((d) => d.type == type).toList();
  }

  List<Document> getDocumentsByStatus(DocumentStatus status) {
    return _documents.where((d) => d.status == status).toList();
  }

  List<Document> getDocumentsByOrder(String orderId) {
    return _documents.where((d) => d.orderId == orderId).toList();
  }
}
