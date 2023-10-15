import 'package:dio/dio.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/util/api_exception.dart';

abstract class IAuthnticationDatasource {
  Future<void> register(
    String username,
    String password,
    String passwordConfirm,
  );

  Future<String> login(
    String username,
    String password,
  );
}

class AuthenticationRemote implements IAuthnticationDatasource {
  final Dio _dio = locator.get();

  @override
  Future<void> register(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      final respoinse = await _dio.post(
        'collections/users/records',
        data: {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm
        },
      );
      
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      var respons = await _dio.post(
        'collections/users/auth-with-password',
        data: {
          'identity': username,
          'password': password,
        },
      );
      if (respons.statusCode == 200) {
        return respons.data?['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
    return '';
  }
}
