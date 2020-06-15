import 'package:d_coffer/jsonserialize/order/data.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  Map<String, OrderData> _orderData = {};

  get data => _orderData;

  /// 初始化
  init(List<OrderData> data) {
    _orderData = {};
    data.forEach((val) {
      _orderData['${val.goodsId}'] = val;
    });
  }
}