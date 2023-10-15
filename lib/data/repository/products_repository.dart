import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/datasourc/products_datasourc.dart';
import 'package:flutter_application_1/data/model/product.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/util/api_exception.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getHotest();
  Future<Either<String, List<Product>>> getBestSeller();
}

class ProductRepository extends IProductRepository {
  final IProductDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      var responce = await _datasource.getProducts();
      return right(responce);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSeller() async {
    try {
      var responce = await _datasource.getBestSeller();
      return right(responce);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Product>>> getHotest() async {
    try {
      var responce = await _datasource.getHotest();
      return right(responce);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای محتوای متنی ندارد');
    }
  }
}
