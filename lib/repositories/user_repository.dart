import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/network/api_client.dart';

abstract class UserRepository {
  Future<UserEntity> getProfile();
  Future<UserEntity> updateProfile({required UserEntity userEntity});
}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({required this.apiClient});
  ApiClient apiClient;

  @override
  Future<UserEntity> getProfile() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    //Mock data
    return UserEntity.mockData();
  }

  @override
  Future<UserEntity> updateProfile({required UserEntity userEntity}) async {
    return UserEntity.updateProfile(userEntity: userEntity);
  }
}
