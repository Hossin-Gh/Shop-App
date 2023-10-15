import 'package:dio/dio.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/data/model/category.dart';
import 'package:flutter_application_1/util/api_exception.dart';

abstract class ICategoryDataSource {
  Future<List<Category>> getCategories();
}

class CategoryRemoteDataSource extends ICategoryDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Category>> getCategories() async {
    try {
      var respons = await _dio.get(
        '/collections/category/records',
      );

      return respons.data['items']
          .map<Category>((jsonObject) => Category.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
