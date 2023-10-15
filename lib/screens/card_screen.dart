// ignore_for_file: must_be_immutable

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widget/cached_image.dart';
import 'package:flutter_application_1/bloc/basket/basket_bloc.dart';
import 'package:flutter_application_1/bloc/basket/basket_state.dart';
import 'package:flutter_application_1/constans/colors.dart';
import 'package:flutter_application_1/data/model/card/card_items.dart';
import 'package:flutter_application_1/util/extenstions/string_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

class CardScr extends StatefulWidget {
  const CardScr({super.key});

  @override
  State<CardScr> createState() => _CardScrState();
}

class _CardScrState extends State<CardScr> {
  PaymentRequest _peymentRequest = PaymentRequest();

  @override
  void initState() {
    super.initState();
    _peymentRequest.setIsSandBox(true);
    _peymentRequest.setAmount(10000);
    _peymentRequest.setDescription('this is for test');
    // _peymentRequest.setCallbackURL('scheme://host');
    _peymentRequest.setCallbackURL('expertflutter://host');
    //! ============================================================================================================================
    _peymentRequest.setMerchantID('bayad az zarin pal gerft');
  }

  @override
  Widget build(BuildContext context) {
    // int finalPrice;
    return Scaffold(
      backgroundColor: CustomColor.backgroundScr,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 44, right: 44, top: 10, bottom: 34),
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                    'assets/images/icon_apple_blue.png'),
                                const Text(
                                  'سبد خرید',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: CustomColor.blue,
                                    fontFamily: 'SB',
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (state is BasketDataFetchState) ...{
                      state.basketItems.fold(
                        (error) {
                          return SliverToBoxAdapter(
                            child: Text(
                              error,
                              style: const TextStyle(
                                fontFamily: 'ab',
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                        (list) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: list.length,
                              (context, index) {
                                return CardItem(list[index]);
                              },
                            ),
                          );
                        },
                      )
                    },
                    const SliverPadding(padding: EdgeInsets.only(bottom: 60))
                  ],
                ),
                if (state is BasketDataFetchState) ...{
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 44, right: 44, bottom: 10),
                    child: SizedBox(
                      height: 53,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle:
                              const TextStyle(fontFamily: 'sm', fontSize: 18),
                          backgroundColor: CustomColor.green,
                          elevation: 10,
                          shadowColor: const Color.fromARGB(255, 48, 134, 109),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onPressed: () {
                          _peymentRequest.setAmount(state.basketFinalPrice);
                          ZarinPal().startPayment(
                            _peymentRequest,
                            (status, paymentGatewayUri) => {
                              if (state == 100)
                                {
                                  launchUrl(
                                    Uri.parse(paymentGatewayUri!),
                                    mode: LaunchMode.externalApplication,
                                  ),
                                },
                            },
                          );
                        },
                        child: Text(
                          (state.basketFinalPrice == 0)
                              ? '!در سبد خرید محصولی قرار ندارد'
                              : state.basketFinalPrice.toString(),
                          style: const TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                },
              ],
            );
          },
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  BasketItem item;
  CardItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.name ?? 'بدون اسم',
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          style: const TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'گارانتی 18 ماه انتلس',
                          style: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: CustomColor.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                child: Text(
                                  '%3',
                                  style: TextStyle(
                                    fontFamily: 'sb',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              'تومان',
                              style: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${item.realPrice}',
                              style: const TextStyle(
                                fontFamily: 'sm',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  width: 1,
                                  color: CustomColor.red,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 6,
                                  top: 2,
                                  bottom: 2,
                                  left: 6,
                                ),
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'حذف',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontFamily: 'sb',
                                        fontSize: 12,
                                        color: CustomColor.red,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Image.asset('assets/images/icon_trash.png')
                                  ],
                                ),
                              ),
                            ),
                            OptionCheap(
                              '256 گیگابایت',
                              color: '4287f5',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    height: 104,
                    width: 75,
                    child: CachedImageWidget(
                      imageURL: item.thumbnail.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              lineThickness: 3.0,
              dashLength: 8.0,
              dashColor: CustomColor.gray.withOpacity(0.5),
              dashGapLength: 3.0,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${item.price}',
                  style: const TextStyle(
                    fontFamily: 'sb',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'تومان',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCheap extends StatelessWidget {
  String? color;
  String title;
  OptionCheap(this.title, {this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          width: 1,
          color: CustomColor.gray,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 6, top: 2, bottom: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10),
            if (color != null) ...{
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.parseToColor(),
                ),
              )
            },
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontFamily: 'sm',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
