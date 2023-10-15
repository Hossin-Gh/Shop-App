import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/model/product.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/util/api_exception.dart';

abstract class ICategoryProductDataSourc {
  Future<List<Product>> getProductByCategoryId(String categoryId);
}

class CategoryProductRemoteDatasource extends ICategoryProductDataSourc {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProductByCategoryId(String categoryId) async {
    try {
      Map<String, String> queryParams = {'filter': 'category="$categoryId"'};

      Response<dynamic> respones;

      if (categoryId == '78q8w901e6iipuk') {
        respones = await _dio.get('collections/products/records');
      } else {
        respones = await _dio.get('collections/products/records',
            queryParameters: queryParams);
      }
      return respones.data['items']
          .map<Product>((jsonObject) => Product.froMapJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
