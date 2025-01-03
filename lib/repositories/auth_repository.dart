import 'package:flutter_base/database/secure_storage_helper.dart';
import 'package:flutter_base/models/entities/token_entity.dart';
import 'package:flutter_base/network/api_client.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<TokenEntity?> signIn(String username, String password);

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.apiClient});
  ApiClient apiClient;

  @override
  Future<TokenEntity?> getToken() async {
    return SecureStorageHelper.instance.getToken();
  }

  @override
  Future<void> removeToken() async {
    return SecureStorageHelper.instance.removeToken();
  }

  @override
  Future<void> saveToken(TokenEntity token) async {
    return SecureStorageHelper.instance.saveToken(token);
  }

  @override
  Future<TokenEntity?> signIn(String username, String password) async {
    //Todo
    await Future<void>.delayed(const Duration(seconds: 2));
    return TokenEntity(
      accessToken: 'app_access_token',
      refreshToken: 'app_refresh_token',
    );
  }

  @override
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return true;
  }
}
