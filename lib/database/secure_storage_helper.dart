import 'dart:async';
import 'dart:convert';

import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_base/models/entities/token_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  SecureStorageHelper._(this._storage);
  // The value stored in SecureStore will
  // not be deleted when the app is uninstalled.
  static const _apiTokenKey = 'api_token';

  final FlutterSecureStorage _storage;

  static final SecureStorageHelper _instance =
      SecureStorageHelper._(const FlutterSecureStorage());

  /// Get SecureStorageHelper instance
  static SecureStorageHelper get instance => _instance;

  /// Save token
  Future<void> saveToken(TokenEntity token) async {
    await _storage.write(key: _apiTokenKey, value: jsonEncode(token.toJson()));
  }

  /// Remove token
  Future<void> removeToken() async {
    await _storage.delete(key: _apiTokenKey);
  }

  /// Get token
  Future<TokenEntity?> getToken() async {
    try {
      //If it is the first time opening the app after installation,
      // the value in SecureStore will be deleted.
      final isFirstRun = await SharedPreferencesHelper.isFirstRun();
      if (isFirstRun) {
        unawaited(removeToken());
        return null;
      }
      final tokenEncoded = await _storage.read(key: _apiTokenKey);
      if (tokenEncoded == null) {
        return null;
      }
      return TokenEntity.fromJson(
        jsonDecode(tokenEncoded) as Map<String, dynamic>,
      );
    } catch (e) {
      return null;
    }
  }
}
