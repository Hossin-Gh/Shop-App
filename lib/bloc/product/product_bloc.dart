import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/bloc/product/product_event.dart';
import 'package:flutter_application_1/bloc/product/product_state.dart';
import 'package:flutter_application_1/data/model/card/card_items.dart';
import 'package:flutter_application_1/data/repository/basket_repository.dart';
import 'package:flutter_application_1/data/repository/product_detail_repository.dart';
import 'package:flutter_application_1/di/di.dart';

class ProductBloc extends Bloc<ProductDetailEvent, ProductState> {
  final IProductDetailRepository _productRepository = locator.get();
  final IBasketRepository _basketRepository = locator.get();

  ProductBloc() : super(ProductDetailInitState()) {
    on<ProductDetailInitializeEvent>(
      (event, emit) async {
        emit(ProductDetailLoadingState());

        var productImage =
            await _productRepository.getProductImage(event.productId);
        var productVariant =
            await _productRepository.getProductVariant(event.productId);
        var productCatergory =
            await _productRepository.getProductCategory(event.categoryId);
        var productProperties =
            await _productRepository.getProductProperties(event.productId);

        emit(
          ProductDetailResponseState(
            productImage,
            productVariant,
            productCatergory,
            productProperties,
          ),
        );
      },
    );

    on<ProductAddedToBasket>(
      (event, emit) {
        var basketItem = BasketItem(
          event.product.id,
          event.product.collectionId,
          event.product.thumbnail,
          event.product.discountPrice,
          event.product.price,
          event.product.name,
          event.product.categoryId,
        );
        _basketRepository.addProductToBasket(basketItem);
      },
    );
  }
}
