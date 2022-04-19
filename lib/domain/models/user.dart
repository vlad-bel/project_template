import 'dart:convert' as dart_convert;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

String encodeUserToString(User user) => dart_convert.json.encode(user.toMap());

@JsonSerializable(ignoreUnannotated: false)
class User {
  const User({
    this.id,
    this.email,
    this.registerTime,
    this.password,
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'register_time')
  final DateTime? registerTime;
  @JsonKey(name: 'password')
  final String? password;

  factory User.fromMap(Map<String, dynamic>? map) {
    if (map == null) throw ('user_from_map_error');

    return _$UserFromJson(map);
  }

  Map<String, dynamic> toMap() {
    return _$UserToJson(this);
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, registerTime: $registerTime, password: $password}';
  }
}
