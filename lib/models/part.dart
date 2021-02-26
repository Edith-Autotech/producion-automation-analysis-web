import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Part {
  final String companyName;
  final String noOfOperations;
  final String partName;
  final String partNumber;
  Part({
    this.companyName,
    this.noOfOperations,
    this.partName,
    this.partNumber,
  });

  factory Part.fromDocument(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    return Part(
      companyName: data['company_name'].toString(),
      noOfOperations: data['no_of_operations'].toString(),
      partName: data['part_name'].toString(),
      partNumber: data['part_number'].toString(),
    );
  }

  Part copyWith({
    String companyName,
    String noOfOperations,
    String partName,
    String partNumber,
  }) {
    return Part(
      companyName: companyName ?? this.companyName,
      noOfOperations: noOfOperations ?? this.noOfOperations,
      partName: partName ?? this.partName,
      partNumber: partNumber ?? this.partNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'noOfOperations': noOfOperations,
      'partName': partName,
      'partNumber': partNumber,
    };
  }

  factory Part.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Part(
      companyName: map['companyName'],
      noOfOperations: map['noOfOperations'],
      partName: map['partName'],
      partNumber: map['partNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Part.fromJson(String source) => Part.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Part(companyName: $companyName, noOfOperations: $noOfOperations, partName: $partName, partNumber: $partNumber)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Part &&
        o.companyName == companyName &&
        o.noOfOperations == noOfOperations &&
        o.partName == partName &&
        o.partNumber == partNumber;
  }

  @override
  int get hashCode {
    return companyName.hashCode ^
        noOfOperations.hashCode ^
        partName.hashCode ^
        partNumber.hashCode;
  }
}
