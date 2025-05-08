import 'package:hive_flutter/hive_flutter.dart';
import '../shared/models/user_response_model.dart';

class HiveService {
  static final Box<UserResponseModel> _userBox = Hive.box<UserResponseModel>(
    'user',
  );
  static final Box<String> _authBox = Hive.box<String>('auth');

  static Future<void> saveUser(UserResponseModel user) async {
    await _userBox.put('user', user);
  }

  static UserResponseModel? getUser() {
    return _userBox.get('user');
  }

  static Future<void> deleteUser() async {
    await _userBox.delete('user');
  }

  static Future<void> saveToken(String token) async {
    await _authBox.put('token', token);
  }

  static String? getToken() {
    return _authBox.get('token');
  }

  static Future<void> deleteToken() async {
    await _authBox.delete('token');
  }

  static Future<void> clearAll() async {
    await _userBox.clear();
    await _authBox.clear();
  }
}
