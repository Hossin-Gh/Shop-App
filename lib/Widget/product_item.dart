import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widget/cached_image.dart';
import 'package:flutter_application_1/bloc/basket/basket_bloc.dart';
import 'package:flutter_application_1/constans/colors.dart';
import 'package:flutter_application_1/data/model/product.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/screens/products_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  Product  product;
  ProductItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider<BasketBloc>.value(
              value: locator.get<BasketBloc>(),
              child: ProductsDetailScr(product),
            ),
          ),
        );
      },
      child: Container(
        height: 216,
        width: 160,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Expanded(child: Container()),
                SizedBox(
                  height: 100,
                  child: CachedImageWidget(imageURL: product.thumbnail!),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/images/active_fav_product.png'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: CustomColor.red,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      child: Text(
                        '%${product.persent}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'sb',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Text(
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    product.name!,
                    style: const TextStyle(fontFamily: 'SM'),
                  ),
                ),
                Container(
                  height: 53,
                  width: 160,
                  decoration: const BoxDecoration(
                    color: CustomColor.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor.blue,
                        offset: Offset(0.0, 15),
                        blurRadius: 25,
                        spreadRadius: -12,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        const Text(
                          'تومان',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.price.toString(),
                              style: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 10,
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 4,
                              ),
                            ),
                            Text(
                              product.realPrice.toString(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset(
                              'assets/images/icon_right_arrow_cricle.png'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
