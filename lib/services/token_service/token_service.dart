import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class TokenManager {
  static final String _accessTokenKey = 'access_token';
  static final String _tokenTypeKey = 'token_type';
  static final String _refreshTokenKey = 'refresh_token';
  static final String _tokenExpireKey = 'token_expire';

  static Future<String?> getAccesToken() async {
    String? token = await FlutterSecureStorage().read(key: _accessTokenKey);
    return token;
  }

  static Future<void> setAccessToken(
    String? token,
  ) async {
    await FlutterSecureStorage().write(
      key: _accessTokenKey,
      value: token,
    );
  }

  static Future<String?> getRefreshToken() async {
    String? token = await FlutterSecureStorage().read(key: _refreshTokenKey);
    return token;
  }

  static Future<void> setRefreshToken(String? token) async {
    await FlutterSecureStorage().write(
      key: _refreshTokenKey,
      value: token,
    );
  }

  static Future<void> setTokenExpire(int expire) async {
    return await FlutterSecureStorage().write(
      key: _tokenExpireKey,
      value: DateTime.now().add(Duration(seconds: expire)).second.toString(),
    );
  }

  static Future<int?> getTokenExpire() async {
    final tokenExpireString = await FlutterSecureStorage().read(
      key: _tokenExpireKey,
    );

    if (tokenExpireString == null) {
      return null;
    }

    return int.parse(tokenExpireString);
  }

  static Future<bool> canTokenRefresh() async {
    var time = await getTokenExpire();
    if (time == null || time == 0) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch > time;
  }

  static Future<bool> removeTokenData() async {
    final storage = FlutterSecureStorage();

    await storage.delete(key: _accessTokenKey);
    await storage.delete(key: _refreshTokenKey);
    await storage.delete(key: _tokenTypeKey);
    await storage.delete(key: _tokenExpireKey);

    return Future.value(true);
  }
}
