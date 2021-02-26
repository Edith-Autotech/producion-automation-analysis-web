import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CountModel {
  final String date;
  final int count;
  final String idleTime;
  final String productionTime;
  final String standbyTime;
  CountModel({
    this.date,
    this.count,
    this.idleTime,
    this.productionTime,
    this.standbyTime,
  });
  factory CountModel.fromDocument(String date,
      {DocumentSnapshot snapshot}) {
    var data = snapshot.data();
    return CountModel(
      date: date,
      count: data['count'],
      idleTime: data['idle_time'],
      productionTime: data['production_time'],
      standbyTime: data['standby_time'],
    );
  }
  factory CountModel.returnNullModel(String dateString) {
    return CountModel(
      count: 0,
      date: dateString,
      idleTime: "No Data",
      productionTime: "No Data",
      standbyTime: "No Data",
    );
  }

  CountModel copyWith({
    String date,
    int count,
    String idleTime,
    String productionTime,
    String standbyTime,
  }) {
    return CountModel(
      date: date ?? this.date,
      count: count ?? this.count,
      idleTime: idleTime ?? this.idleTime,
      productionTime: productionTime ?? this.productionTime,
      standbyTime: standbyTime ?? this.standbyTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'count': count,
      'idleTime': idleTime,
      'productionTime': productionTime,
      'standbyTime': standbyTime,
    };
  }

  factory CountModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CountModel(
      date: map['date'],
      count: map['count'],
      idleTime: map['idleTime'],
      productionTime: map['productionTime'],
      standbyTime: map['standbyTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CountModel.fromJson(String source) =>
      CountModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CountModel(date: $date, count: $count, idleTime: $idleTime, productionTime: $productionTime, standbyTime: $standbyTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CountModel &&
        o.date == date &&
        o.count == count &&
        o.idleTime == idleTime &&
        o.productionTime == productionTime &&
        o.standbyTime == standbyTime;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        count.hashCode ^
        idleTime.hashCode ^
        productionTime.hashCode ^
        standbyTime.hashCode;
  }
}
