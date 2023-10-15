import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/datasourc/products_detail_datasource.dart';
import 'package:flutter_application_1/data/model/category.dart';
import 'package:flutter_application_1/data/model/product_image.dart';
import 'package:flutter_application_1/data/model/product_properties.dart';
import 'package:flutter_application_1/data/model/product_variant.dart';
import 'package:flutter_application_1/data/model/variants_type.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/util/api_exception.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getProductImage(String productId);
  
  Future<Either<String, List<VariantType>>> getVariantType();
  Future<Either<String, List<ProductVariants>>> getProductVariant(
      String productId);
  Future<Either<String, Category>> getProductCategory(String categoriId);
  Future<Either<String, List<ProductProperties>>> getProductProperties(
      String productId);
}

class ProductDetialRepository extends IProductDetailRepository {
  final IProductDetailDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<ProductImage>>> getProductImage(
      String productId) async {
    try {
      var responce = await _datasource.getGallery(productId);
      return right(responce);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantType() async {
    try {
      var responce = await _datasource.getVariantType();
      return right(responce);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductVariants>>> getProductVariant(
      String productId) async {
    try {
      var responce = await _datasource.getProductVariants(productId);
      return right(responce);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String categoriId) async {
    try {
      var responce = await _datasource.getProductCatrgory(categoriId);
      return right(responce);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductProperties>>> getProductProperties(
      String productId) async {
    try {
      var response = await _datasource.getProductProperties(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای محتوای متنی ندارد');
    }
  }
}
