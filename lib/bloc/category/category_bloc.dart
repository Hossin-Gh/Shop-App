import 'package:flutter_application_1/bloc/category/category_event.dart';
import 'package:flutter_application_1/bloc/category/category_state.dart';
import 'package:flutter_application_1/data/repository/category_repository.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _respository = locator.get();

  CategoryBloc() : super(CategoryInitiatState()) {
    on<CategoryRequestList>(
      (event, emit) async {
        emit(CategoryLoadingState());
        var response = await _respository.getCategories();
        emit(CategoryResponseState(response));
      },
    );
  }
}
