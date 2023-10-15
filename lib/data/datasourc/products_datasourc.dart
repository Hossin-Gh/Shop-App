import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/model/product.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/util/api_exception.dart';

abstract class IProductDatasource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getHotest();
  Future<List<Product>> getBestSeller();
}

class ProductRemoreDatasource extends IProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProducts() async {
    try {
      var respones = await _dio.get('collections/products/records');
      return respones.data['items']
          .map<Product>((jsonObject) => Product.froMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unlnown erorr');
    }
  }

  @override
  Future<List<Product>> getBestSeller() async {
    Map<String, String> queryParams = {'filter': 'popularity="Best Seller"'};

    try {
      var respones = await _dio.get('collections/products/records',
          queryParameters: queryParams);
      return respones.data['items']
          .map<Product>((jsonObject) => Product.froMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unlnown erorr');
    }
  }

  @override
  Future<List<Product>> getHotest() async {
    try {
      Map<String, String> queryParams = {'filter': 'popularity="Hotest"'};

      var respones = await _dio.get('collections/products/records',
          queryParameters: queryParams);
      return respones.data['items']
          .map<Product>((jsonObject) => Product.froMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unlnown erorr');
    }
  }
}
