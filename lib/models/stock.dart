import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Stock {
  final String operationNo;
  final String stock;
  Stock({
    this.operationNo,
    this.stock,
  });
  factory Stock.fromDocument(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    return Stock(
      operationNo: snapshot.id,
      stock: data['stock'].toString(),
    );
  }

  Stock copyWith({
    String operationNo,
    String stock,
  }) {
    return Stock(
      operationNo: operationNo ?? this.operationNo,
      stock: stock ?? this.stock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'operationNo': operationNo,
      'stock': stock,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Stock(
      operationNo: map['operationNo'],
      stock: map['stock'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) => Stock.fromMap(json.decode(source));

  @override
  String toString() => 'Stock(operationNo: $operationNo, stock: $stock)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Stock && o.operationNo == operationNo && o.stock == stock;
  }

  @override
  int get hashCode => operationNo.hashCode ^ stock.hashCode;
}
