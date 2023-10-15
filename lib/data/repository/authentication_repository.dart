import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/datasourc/authentication_datasource.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/util/api_exception.dart';
import 'package:flutter_application_1/util/auth_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';

abstract class IAthuRepository {
  Future<Either<String, String>> register(
    String username,
    String password,
    String passawordConfirm,
  );

  Future<Either<String, String>> login(String username, String password);
}

class AthuenticationRepository extends IAthuRepository {
  final IAuthnticationDatasource _dataSource = locator.get();
  // final SharedPreferences _sharedPref = locator.get();
  @override
  Future<Either<String, String>> register(
      String username, String password, String passawordConfirm) async {
    try {
      await _dataSource.register('armanm', '12345678', '12345678');
      return right('correct');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'null');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      var token = await _dataSource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right('welcome');
      } else {
        return left('erorr');
      }
    } on ApiException catch (ex) {
      return left('${ex.message}');
    }
  }
}
