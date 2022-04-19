// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      email: json['email'] as String?,
      registerTime: json['register_time'] == null
          ? null
          : DateTime.parse(json['register_time'] as String),
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'register_time': instance.registerTime?.toIso8601String(),
      'password': instance.password,
    };
