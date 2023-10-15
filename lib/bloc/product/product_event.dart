import 'package:flutter_application_1/data/model/product.dart';

abstract class ProductDetailEvent {}

class ProductDetailInitializeEvent extends ProductDetailEvent {
  String productId;
  String categoryId;
  ProductDetailInitializeEvent(this.productId, this.categoryId);
}

class ProductAddedToBasket extends ProductDetailEvent {
  Product product;
  ProductAddedToBasket(this.product);
}
