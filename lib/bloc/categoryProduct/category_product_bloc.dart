import 'package:flutter_application_1/bloc/categoryProduct/category_product_event.dart';
import 'package:flutter_application_1/data/repository/category_product_repository.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_product_state.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ICategoryProductRepository _repository = locator.get();
  
  CategoryProductBloc() : super(CategoryProdcutloadingState()) {
    on<CategoryProductInitialize>(
      (event, emit) async {
        var respones = await _repository.getProductCategoryId(event.categoryId);
        emit(CategoryProductResopnseSuccessState(respones));
      },
    );
  }
}
