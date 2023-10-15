import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/model/category.dart';
import 'package:flutter_application_1/data/model/product_image.dart';
import 'package:flutter_application_1/data/model/product_properties.dart';
import 'package:flutter_application_1/data/model/product_variant.dart';

abstract class ProductState {}

class ProductDetailInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> productImage;
  Either<String, List<ProductVariants>> productVariant;
  Either<String, Category> productCategory;
  Either<String, List<ProductProperties>> productProperties;

  ProductDetailResponseState(
    this.productImage,
    this.productVariant,
    this.productCategory,
    this.productProperties,
  );
}
