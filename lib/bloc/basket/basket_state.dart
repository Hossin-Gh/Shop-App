import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/model/card/card_items.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketLoadingState extends BasketState {}

class BasketDataFetchState extends BasketState {
  Either<String, List<BasketItem>> basketItems;
  int basketFinalPrice;
  BasketDataFetchState(this.basketItems, this.basketFinalPrice);
}
