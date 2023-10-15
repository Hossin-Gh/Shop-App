import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/model/banner.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/util/api_exception.dart';

abstract class IBannerDatasource {
  Future<List<Banners>> getBanner();
}

class BannerRemoteDataSource extends IBannerDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Banners>> getBanner() async {
    try {
      var respons = await _dio.get(
        'collections/banner/records',
      );

      return respons.data['items']
          .map<Banners>((jsonObject) => Banners.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
