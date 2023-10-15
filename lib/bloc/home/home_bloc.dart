import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/bloc/home/home_event.dart';
import 'package:flutter_application_1/bloc/home/home_state.dart';
import 'package:flutter_application_1/data/repository/banner_repository.dart';
import 'package:flutter_application_1/data/repository/category_repository.dart';
import 'package:flutter_application_1/data/repository/products_repository.dart';
import 'package:flutter_application_1/di/di.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICategoryRepository _catrgoryRepository = locator.get();
  final IProductRepository _productRepository = locator.get();

  HomeBloc() : super(HomeInitState()) {
    on<HomeRequestList>(
      (event, emit) async {
        emit(HomeLoadingState());

        var bannerList = await _bannerRepository.getBanner();
        var categoryList = await _catrgoryRepository.getCategories();
        var productList = await _productRepository.getProducts();
        var hotestProductsList = await _productRepository.getHotest();
        var bestSellerProductsList = await _productRepository.getBestSeller();

        emit(HomeResponseState(
          bannerList,
          categoryList,
          productList,
          hotestProductsList,
          bestSellerProductsList,
        ));
      },
    );
  }
}
