import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/model/product.dart';

abstract class CategoryProductState {}

class CategoryProdcutloadingState extends CategoryProductState {}

class CategoryProductResopnseSuccessState extends CategoryProductState {
  Either<String, List<Product>> productListByCatrgoryId;

  CategoryProductResopnseSuccessState(this.productListByCatrgoryId);
}
