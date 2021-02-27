import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FactoryModel {
  final String key;
  final String name;
  FactoryModel({
    this.key,
    this.name,
  })  : assert(key != null),
        assert(name != null);

  factory FactoryModel.fromDocument(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    print("DATA is " + data.toString());
    return FactoryModel(
      key: data["key"],
      name: data["name"],
    );
  }

  FactoryModel copyWith({
    String key,
    String name,
  }) {
    return FactoryModel(
      key: key ?? this.key,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'name': name,
    };
  }

  factory FactoryModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FactoryModel(
      key: map['key'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FactoryModel.fromJson(String source) =>
      FactoryModel.fromMap(json.decode(source));

  @override
  String toString() => 'FactoryModel(key: $key, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FactoryModel && o.key == key && o.name == name;
  }

  @override
  int get hashCode => key.hashCode ^ name.hashCode;
}
