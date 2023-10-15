import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/bloc/basket/basket_event.dart';
import 'package:flutter_application_1/bloc/basket/basket_state.dart';
import 'package:flutter_application_1/data/repository/basket_repository.dart';
import 'package:flutter_application_1/di/di.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _repository = locator.get();

  BasketBloc() : super(BasketInitState()) {
    on<BasketFetachFromHineEvent>(
      (event, emit) async {
        var basketItemList = await _repository.getAllBasketItems();
        var basketFinalPrice = await _repository.getBasketFinalPrice();
        emit(
          BasketDataFetchState(basketItemList,basketFinalPrice),
        );
      },
    );
  }
}
