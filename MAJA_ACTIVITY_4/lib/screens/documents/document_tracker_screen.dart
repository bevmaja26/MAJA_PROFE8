import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/document_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/document_model.dart';

class DocumentTrackerScreen extends StatefulWidget {
  const DocumentTrackerScreen({super.key});

  @override
  State<DocumentTrackerScreen> createState() => _DocumentTrackerScreenState();
}

class _DocumentTrackerScreenState extends State<DocumentTrackerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DocumentType? _filterType;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadDocuments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadDocuments() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final documentProvider =
        Provider.of<DocumentProvider>(context, listen: false);

    if (authProvider.currentUser != null) {
      await documentProvider.loadDocuments(authProvider.currentUser!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Document Tracker'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTypeFilter(null, 'All Types'),
                  ...DocumentType.values.map(
                    (type) => _buildTypeFilter(type, _getTypeLabel(type)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDocumentList(null),
                _buildDocumentList(DocumentStatus.pending),
                _buildDocumentList(DocumentStatus.approved),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeFilter(DocumentType? type, String label) {
    final isSelected = _filterType == type;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _filterType = selected ? type : null;
          });
        },
        backgroundColor: Colors.white,
        selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        checkmarkColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildDocumentList(DocumentStatus? statusFilter) {
    return Consumer<DocumentProvider>(
      builder: (context, documentProvider, child) {
        var documents = statusFilter == null
            ? documentProvider.documents
            : documentProvider.getDocumentsByStatus(statusFilter);

        if (_filterType != null) {
          documents =
              documents.where((doc) => doc.type == _filterType).toList();
        }

        if (documents.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 100,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No documents found',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Documents will appear here after placing orders',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[500],
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final document = documents[index];
            return _buildDocumentCard(document);
          },
        );
      },
    );
  }

  Widget _buildDocumentCard(Document document) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showDocumentDetails(document),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getTypeColor(document.type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getTypeIcon(document.type),
                      color: _getTypeColor(document.type),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document.title,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getTypeLabel(document.type),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(document.status),
                ],
              ),
              if (document.description != null &&
                  document.description!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  document.description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('MMM dd, yyyy').format(document.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.receipt_long,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Order #${document.orderId.substring(0, 8)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(DocumentStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getStatusLabel(status),
        style: TextStyle(
          color: _getStatusColor(status),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showDocumentDetails(Document document) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _getTypeColor(document.type).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getTypeIcon(document.type),
                        color: _getTypeColor(document.type),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 4),
                          _buildStatusChip(document.status),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildDetailRow(
                  'Document Type',
                  _getTypeLabel(document.type),
                  Icons.category,
                ),
                _buildDetailRow(
                  'Order ID',
                  '#${document.orderId.substring(0, 8)}',
                  Icons.receipt_long,
                ),
                _buildDetailRow(
                  'Created',
                  DateFormat('MMM dd, yyyy - hh:mm a')
                      .format(document.createdAt),
                  Icons.calendar_today,
                ),
                if (document.updatedAt != null)
                  _buildDetailRow(
                    'Last Updated',
                    DateFormat('MMM dd, yyyy - hh:mm a')
                        .format(document.updatedAt!),
                    Icons.update,
                  ),
                if (document.description != null &&
                    document.description!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    document.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                if (document.status == DocumentStatus.pending) ...[
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _updateDocumentStatus(
                              document.id,
                              DocumentStatus.approved,
                            );
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Approve'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _updateDocumentStatus(
                              document.id,
                              DocumentStatus.rejected,
                            );
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                          label: const Text('Reject'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateDocumentStatus(String documentId, DocumentStatus status) async {
    final documentProvider =
        Provider.of<DocumentProvider>(context, listen: false);
    await documentProvider.updateDocumentStatus(documentId, status);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Document ${status == DocumentStatus.approved ? 'approved' : 'rejected'}',
          ),
          backgroundColor:
              status == DocumentStatus.approved ? Colors.green : Colors.red,
        ),
      );
    }
  }

  String _getTypeLabel(DocumentType type) {
    switch (type) {
      case DocumentType.receipt:
        return 'Receipt';
      case DocumentType.purchaseOrder:
        return 'Purchase Order';
      case DocumentType.invoice:
        return 'Invoice';
      case DocumentType.deliveryNote:
        return 'Delivery Note';
      case DocumentType.other:
        return 'Other';
    }
  }

  IconData _getTypeIcon(DocumentType type) {
    switch (type) {
      case DocumentType.receipt:
        return Icons.receipt;
      case DocumentType.purchaseOrder:
        return Icons.shopping_cart;
      case DocumentType.invoice:
        return Icons.description;
      case DocumentType.deliveryNote:
        return Icons.local_shipping;
      case DocumentType.other:
        return Icons.insert_drive_file;
    }
  }

  Color _getTypeColor(DocumentType type) {
    switch (type) {
      case DocumentType.receipt:
        return Colors.blue;
      case DocumentType.purchaseOrder:
        return Colors.orange;
      case DocumentType.invoice:
        return Colors.purple;
      case DocumentType.deliveryNote:
        return Colors.teal;
      case DocumentType.other:
        return Colors.grey;
    }
  }

  String _getStatusLabel(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.pending:
        return 'Pending';
      case DocumentStatus.approved:
        return 'Approved';
      case DocumentStatus.rejected:
        return 'Rejected';
    }
  }

  Color _getStatusColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.pending:
        return Colors.orange;
      case DocumentStatus.approved:
        return Colors.green;
      case DocumentStatus.rejected:
        return Colors.red;
    }
  }
}
