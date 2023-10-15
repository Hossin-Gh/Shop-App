import 'package:dio/dio.dart';
import 'package:flutter_application_1/bloc/basket/basket_bloc.dart';
import 'package:flutter_application_1/data/datasourc/authentication_datasource.dart';
import 'package:flutter_application_1/data/datasourc/banner_datasource.dart';
import 'package:flutter_application_1/data/datasourc/basket_datasourc.dart';
import 'package:flutter_application_1/data/datasourc/category_datasource.dart';
import 'package:flutter_application_1/data/datasourc/category_product_datasourc.dart';
import 'package:flutter_application_1/data/datasourc/products_datasourc.dart';
import 'package:flutter_application_1/data/datasourc/products_detail_datasource.dart';
import 'package:flutter_application_1/data/repository/authentication_repository.dart';
import 'package:flutter_application_1/data/repository/banner_repository.dart';
import 'package:flutter_application_1/data/repository/basket_repository.dart';
import 'package:flutter_application_1/data/repository/category_product_repository.dart';
import 'package:flutter_application_1/data/repository/category_repository.dart';
import 'package:flutter_application_1/data/repository/product_detail_repository.dart';
import 'package:flutter_application_1/data/repository/products_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInin() async {
  //********************componenets********************
  //base URL 
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: 'http://startflutter.ir/api/'),
    ),
  );

  //initialized data
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  //********************dataSources********************
  //
  //Auth
  locator
      .registerFactory<IAuthnticationDatasource>(() => AuthenticationRemote());

  //Category
  locator
      .registerFactory<ICategoryDataSource>(() => CategoryRemoteDataSource());

  //Banner
  locator.registerFactory<IBannerDatasource>(() => BannerRemoteDataSource());

  //Products
  locator.registerFactory<IProductDatasource>(() => ProductRemoreDatasource());

  //Product Gallery
  locator.registerFactory<IProductDetailDatasource>(
      () => DetailProductDatasource());

  //Product By Category Id
  locator.registerFactory<ICategoryProductDataSourc>(
      () => CategoryProductRemoteDatasource());

  //Basket Products
  locator.registerFactory<IBasketDatasourc>(() => BasketLocalDatasourc());

  //********************repositories********************
  //
  //Auth
  locator.registerFactory<IAthuRepository>(() => AthuenticationRepository());

  //Category
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());

  //Banner
  locator.registerFactory<IBannerRepository>(() => BannerRepository());

  //Products
  locator.registerFactory<IProductRepository>(() => ProductRepository());

  //Products Gallery
  locator.registerFactory<IProductDetailRepository>(
      () => ProductDetialRepository());

  //Products By Category Id
  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepository());

  //Basket Products
  locator.registerFactory<IBasketRepository>(() => BasketRepository());

  //********************Bloc********************
  //Basket
  locator.registerSingleton<BasketBloc>(BasketBloc());
}
