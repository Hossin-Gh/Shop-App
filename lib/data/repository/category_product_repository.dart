import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/datasourc/category_product_datasourc.dart';
import 'package:flutter_application_1/data/model/product.dart';
import 'package:flutter_application_1/di/di.dart';

import '../../util/api_exception.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductCategoryId(String categoryId);
}

class CategoryProductRepository extends ICategoryProductRepository {
  final ICategoryProductDataSourc _dataSourc = locator.get();

  @override
  Future<Either<String, List<Product>>> getProductCategoryId(
      String categoryId) async {
    try {
      var respones = await _dataSourc.getProductByCategoryId(categoryId);
      return right(respones);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
