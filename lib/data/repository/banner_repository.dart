import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/datasourc/banner_datasource.dart';
import 'package:flutter_application_1/data/model/banner.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/util/api_exception.dart';

abstract class IBannerRepository {
  Future<Either<String, List<Banners>>> getBanner();
}

class BannerRepository extends IBannerRepository {
  final IBannerDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Banners>>> getBanner() async {
    try {
      var responce = await _datasource.getBanner();
      return right(responce);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای محتوای متنی ندارد');
    }
  }
}
