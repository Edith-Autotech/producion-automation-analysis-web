import 'dart:convert';

class UserModel {
  final String uid;
  final bool admin;
  final String name;
  final String imageUrl;
  final String email;
  final String comapanyName;

  UserModel({
    this.uid,
    this.admin,
    this.name,
    this.imageUrl,
    this.email,
    this.comapanyName,
  });

  UserModel copyWith({
    String uid,
    bool admin,
    String name,
    String imageUrl,
    String email,
    String comapanyName,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      admin: admin ?? this.admin,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      email: email ?? this.email,
      comapanyName: comapanyName ?? this.comapanyName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'admin': admin,
      'name': name,
      'imageUrl': imageUrl,
      'email': email,
      'comapanyName': comapanyName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserModel(
      uid: map['uid'],
      admin: map['admin'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      email: map['email'],
      comapanyName: map['comapanyName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, admin: $admin, name: $name, imageUrl: $imageUrl, email: $email, comapanyName: $comapanyName)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserModel &&
      o.uid == uid &&
      o.admin == admin &&
      o.name == name &&
      o.imageUrl == imageUrl &&
      o.email == email &&
      o.comapanyName == comapanyName;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      admin.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      email.hashCode ^
      comapanyName.hashCode;
  }
}
