import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/datasourc/basket_datasourc.dart';
import 'package:flutter_application_1/data/model/card/card_items.dart';
import 'package:flutter_application_1/di/di.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItems();
  Future<int> getBasketFinalPrice();
}

class BasketRepository extends IBasketRepository {
  final IBasketDatasourc _datasourc = locator.get();
  @override
  Future<Either<String, String>> addProductToBasket(
      BasketItem basketItem) async {
    try {
      await _datasourc.addProducts(basketItem);
      return right('محصول اضافه به سبد خرید اضافه شد');
    } catch (ex) {
      return left('خطا در افزودن محصول به سبد خرید');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItems() async {
    try {
      var basketItemaList = await _datasourc.getAllBasketItems();
      return right(basketItemaList);
    } catch (ex) {
      return left('محصولی در سبد خرید اضافه نشده است');
    }
  }

  @override
  Future<int> getBasketFinalPrice() async {
    return _datasourc.getBasketFinalPrice();
  }
}
