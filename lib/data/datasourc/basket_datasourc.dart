import 'package:flutter_application_1/data/model/card/card_items.dart';
import 'package:hive_flutter/adapters.dart';

abstract class IBasketDatasourc {
  Future<void> addProducts(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItems();
  Future<int> getBasketFinalPrice();
}

class BasketLocalDatasourc extends IBasketDatasourc {
  var box = Hive.box<BasketItem>('CardBox');
  @override
  Future<void> addProducts(BasketItem basketItem) async {
    await box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItems() async {
    return box.values.toList();
  }

  @override
  Future<int> getBasketFinalPrice() async{
    var productList = box.values.toList();
    var finalPrice =
        productList.fold(0, (accumulator, item) => accumulator + item.price!);
    return finalPrice;
  }
}
