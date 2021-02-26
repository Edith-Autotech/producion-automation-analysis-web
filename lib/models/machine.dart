import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Machine {
  final String machineId;
  final String currentPart;
  final String currentOperation;
  final String reasonCode;
  final String previousState;
  final String previousTimeStroke;
  Machine({
    this.machineId,
    this.currentPart,
    this.currentOperation,
    this.reasonCode,
    this.previousState,
    @required this.previousTimeStroke,
  });

  factory Machine.fromDocument(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    return Machine(
      machineId: snapshot.id,
      currentOperation: data["working_operation_number"],
      currentPart: data["working_part_number"],
      previousState: data["previous_state"],
      reasonCode: data["reason_code"],
      previousTimeStroke: data["pts"],
    );
  }

  Machine copyWith({
    String machineId,
    String currentPart,
    String currentOperation,
    String reasonCode,
    String previousState,
    String previousTimeStroke,
  }) {
    return Machine(
      machineId: machineId ?? this.machineId,
      currentPart: currentPart ?? this.currentPart,
      currentOperation: currentOperation ?? this.currentOperation,
      reasonCode: reasonCode ?? this.reasonCode,
      previousState: previousState ?? this.previousState,
      previousTimeStroke: previousTimeStroke ?? this.previousTimeStroke,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'machineId': machineId,
      'currentPart': currentPart,
      'currentOperation': currentOperation,
      'reasonCode': reasonCode,
      'previousState': previousState,
      'previousTimeStroke': previousTimeStroke,
    };
  }

  factory Machine.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Machine(
      machineId: map['machineId'],
      currentPart: map['currentPart'],
      currentOperation: map['currentOperation'],
      reasonCode: map['reasonCode'],
      previousState: map['previousState'],
      previousTimeStroke: map['previousTimeStroke'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Machine.fromJson(String source) =>
      Machine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Machine(machineId: $machineId, currentPart: $currentPart, currentOperation: $currentOperation, reasonCode: $reasonCode, previousState: $previousState, previousTimeStroke: $previousTimeStroke)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Machine &&
        o.machineId == machineId &&
        o.currentPart == currentPart &&
        o.currentOperation == currentOperation &&
        o.reasonCode == reasonCode &&
        o.previousState == previousState &&
        o.previousTimeStroke == previousTimeStroke;
  }

  @override
  int get hashCode {
    return machineId.hashCode ^
        currentPart.hashCode ^
        currentOperation.hashCode ^
        reasonCode.hashCode ^
        previousState.hashCode ^
        previousTimeStroke.hashCode;
  }
}
