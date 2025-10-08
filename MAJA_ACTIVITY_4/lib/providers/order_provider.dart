import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> loadOrders(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getStringList('orders_$userId') ?? [];

    _orders =
        ordersJson.map((json) => Order.fromJson(jsonDecode(json))).toList();

    notifyListeners();
  }

  Future<Order> createOrder({
    required String userId,
    required List<CartItem> items,
    required double totalAmount,
    String? shippingAddress,
  }) async {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      items: items,
      totalAmount: totalAmount,
      status: OrderStatus.pending,
      paymentStatus: PaymentStatus.pending,
      shippingAddress: shippingAddress,
      createdAt: DateTime.now(),
    );

    _orders.insert(0, order);
    await _saveOrders(userId);
    notifyListeners();

    return order;
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index >= 0) {
      final order = _orders[index];
      _orders[index] = Order(
        id: order.id,
        userId: order.userId,
        items: order.items,
        totalAmount: order.totalAmount,
        status: status,
        paymentStatus: order.paymentStatus,
        shippingAddress: order.shippingAddress,
        createdAt: order.createdAt,
        deliveredAt: status == OrderStatus.delivered
            ? DateTime.now()
            : order.deliveredAt,
      );

      await _saveOrders(order.userId);
      notifyListeners();
    }
  }

  Future<void> updatePaymentStatus(String orderId, PaymentStatus status) async {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index >= 0) {
      final order = _orders[index];
      _orders[index] = Order(
        id: order.id,
        userId: order.userId,
        items: order.items,
        totalAmount: order.totalAmount,
        status: order.status,
        paymentStatus: status,
        shippingAddress: order.shippingAddress,
        createdAt: order.createdAt,
        deliveredAt: order.deliveredAt,
      );

      await _saveOrders(order.userId);
      notifyListeners();
    }
  }

  Future<void> _saveOrders(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = _orders
        .where((o) => o.userId == userId)
        .map((o) => jsonEncode(o.toJson()))
        .toList();

    await prefs.setStringList('orders_$userId', ordersJson);
  }

  List<Order> getOrdersByStatus(OrderStatus status) {
    return _orders.where((o) => o.status == status).toList();
  }

  Order? getOrderById(String id) {
    try {
      return _orders.firstWhere((o) => o.id == id);
    } catch (e) {
      return null;
    }
  }
}
