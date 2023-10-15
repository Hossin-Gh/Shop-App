import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/model/banner.dart';
import 'package:flutter_application_1/data/model/category.dart';
import 'package:flutter_application_1/data/model/product.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<Banners>> response;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> hotestProductsList;
  Either<String, List<Product>> bestSellerProductsList;

  HomeResponseState(
    this.response,
    this.categoryList,
    this.productList,
    this.hotestProductsList,
    this.bestSellerProductsList,
  );
}


