import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widget/cached_image.dart';
import 'package:flutter_application_1/bloc/basket/basket_bloc.dart';
import 'package:flutter_application_1/bloc/basket/basket_event.dart';
import 'package:flutter_application_1/bloc/product/product_bloc.dart';
import 'package:flutter_application_1/bloc/product/product_event.dart';
import 'package:flutter_application_1/bloc/product/product_state.dart';
import 'package:flutter_application_1/constans/colors.dart';
import 'package:flutter_application_1/data/model/product.dart';
import 'package:flutter_application_1/data/model/product_image.dart';
import 'package:flutter_application_1/data/model/product_properties.dart';
import 'package:flutter_application_1/data/model/product_variant.dart';
import 'package:flutter_application_1/data/model/variant.dart';
import 'package:flutter_application_1/data/model/variants_type.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProductsDetailScr extends StatefulWidget {
  Product product;

  ProductsDetailScr(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductsDetailScr> createState() => _ProductsDetailScrState();
}

class _ProductsDetailScrState extends State<ProductsDetailScr> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc();
        bloc.add(ProductDetailInitializeEvent(
            widget.product.id!, widget.product.categoryId!));
        return bloc;
      },
      child: DetailContentWidget(parentWidget: widget),
    );
  }
}

class DetailContentWidget extends StatelessWidget {
  const DetailContentWidget({
    super.key,
    required this.parentWidget,
  });

  final ProductsDetailScr parentWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScr,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductDetailLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                },
                if (state is ProductDetailResponseState) ...{
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
                                'assets/images/icon_apple_blue.png',
                              ),
                              Expanded(
                                child: state.productCategory.fold(
                                  (l) {
                                    return const Center(
                                      child: Text(
                                        'اطلاعات محصول',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: CustomColor.blue,
                                          fontFamily: 'SB',
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  },
                                  (productCatrgory) {
                                    return Center(
                                      child: Text(
                                        productCatrgory.title!,
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          color: CustomColor.blue,
                                          fontFamily: 'SB',
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Image.asset('assets/images/icon_back.png'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                },
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      parentWidget.product.name!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'sb',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                //
                //get images from api
                //
                if (state is ProductDetailResponseState) ...{
                  state.productImage.fold(
                    (exception) {
                      return SliverToBoxAdapter(
                        child: Text(exception),
                      );
                    },
                    (imagesList) {
                      return GalleryWidget(
                        imagesList,
                        parentWidget.product.thumbnail!,
                      );
                    },
                  )
                },
                //
                //get variants from api
                //
                if (state is ProductDetailResponseState) ...{
                  state.productVariant.fold(
                    (exception) {
                      return SliverToBoxAdapter(
                        child: Text(exception),
                      );
                    },
                    (productVariantList) {
                      return VariantContainerGenerator(productVariantList);
                    },
                  ),
                },
                if (state is ProductDetailResponseState) ...{
                  state.productProperties.fold(
                    (exception) {
                      return SliverToBoxAdapter(
                        child: Text(exception),
                      );
                    },
                    (productPropertieList) {
                      return ProductInformations(productPropertieList);
                    },
                  ),
                },
                ProductDescription(parentWidget.product.description!),
                SliverToBoxAdapter(
                  child: Container(
                    height: 46,
                    margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(width: 1, color: CustomColor.gray),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Image.asset('assets/images/icon_left_categroy.png'),
                          const SizedBox(width: 10),
                          const Text(
                            'مشاهده',
                            style: TextStyle(
                              fontFamily: 'sb',
                              fontSize: 12,
                              color: CustomColor.blue,
                            ),
                          ),
                          const Spacer(),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 26,
                                width: 26,
                                margin: const EdgeInsets.only(left: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 15,
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 30,
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: const BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 45,
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 60,
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '+10',
                                      style: TextStyle(
                                        fontFamily: 'sb',
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            ': نظرات کاربران',
                            style: TextStyle(
                              fontFamily: 'sm',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const PriceTagButton(),
                        AddToBasketButton(parentWidget.product),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProductInformations extends StatefulWidget {
  List<ProductProperties> propertiesList;
  ProductInformations(this.propertiesList, {super.key});

  @override
  State<ProductInformations> createState() => _ProductInformationsState();
}

class _ProductInformationsState extends State<ProductInformations> {
  bool _visable = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _visable = !_visable;
              });
            },
            child: Container(
              height: 46,
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(width: 1, color: CustomColor.gray),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontFamily: 'sb',
                        fontSize: 12,
                        color: CustomColor.blue,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      ': مشخصات فنی',
                      style: TextStyle(
                        fontFamily: 'sm',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visable,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(width: 1, color: CustomColor.gray),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.propertiesList.length,
                itemBuilder: (context, index) {
                  var properties = widget.propertiesList[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          textDirection: TextDirection.rtl,
                          '${properties.title!} : ${properties.value!}',
                          style: const TextStyle(
                            fontFamily: 'sm',
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  String productDescription;
  ProductDescription(
    this.productDescription, {
    super.key,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: 46,
            margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(width: 1, color: CustomColor.gray),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontFamily: 'sb',
                        fontSize: 12,
                        color: CustomColor.blue,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      ': توضیحات محصول',
                      style: TextStyle(
                        fontFamily: 'sm',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              // height: 46,
              margin: const EdgeInsets.only(left: 44, right: 44, top: 6),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(width: 1, color: CustomColor.gray),
              ),
              child: Text(
                widget.productDescription,
                style: const TextStyle(
                  fontFamily: 'sm',
                  fontSize: 14,
                  height: 1.7,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  List<ProductVariants> productVariantList;
  VariantContainerGenerator(this.productVariantList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantGeneratorChild(productVariant)
            },
          },
        ],
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  ProductVariants variantList;
  VariantGeneratorChild(this.variantList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 44, right: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            variantList.variantType.title!,
            style: const TextStyle(fontSize: 12, fontFamily: 'sm'),
          ),
          const SizedBox(
            height: 10,
          ),
          if (variantList.variantType.type == VariantTypeEnum.COLOR) ...{
            ColorVariantList(variantList.variantList)
          },
          if (variantList.variantType.type == VariantTypeEnum.STORAGE) ...{
            StorageVariantList(variantList.variantList)
          }
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  List<ProductImage> productImageList;
  String defualtProductThumbnail;
  GalleryWidget(this.productImageList, this.defualtProductThumbnail, {Key? key})
      : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: Container(
          height: 284,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/icon_star.png'),
                          const SizedBox(width: 2),
                          const Text(
                            '4.6',
                            style: TextStyle(
                              fontFamily: 'sm',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: CachedImageWidget(
                          imageURL: (widget.productImageList.isEmpty)
                              ? widget.defualtProductThumbnail
                              : widget
                                  .productImageList[selectedImage].imageUrl!,
                        ),
                      ),
                      Image.asset('assets/images/icon_favorite_deactive.png'),
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    bottom: 10,
                    top: 10,
                  ),
                  child: SizedBox(
                    height: 70,
                    child: ListView.builder(
                      itemCount: widget.productImageList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImage = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: CustomColor.gray,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: CachedImageWidget(
                                imageURL:
                                    widget.productImageList[index].imageUrl!,
                                radius: 10,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  Product item;
  AddToBasketButton(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: const BoxDecoration(
            color: CustomColor.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: GestureDetector(
              onTap: () {
                context.read<ProductBloc>().add(ProductAddedToBasket(item));
                context.read<BasketBloc>().add(BasketFetachFromHineEvent());
              },
              child: Container(
                height: 53,
                width: 160,
                color: Colors.transparent,
                child: const Center(
                  child: Text(
                    'افزودن به سبد خرید',
                    style: TextStyle(
                      fontFamily: 'sb',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: const BoxDecoration(
            color: CustomColor.green,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 53,
              width: 160,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
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
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '46,000,000',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 10,
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 4,
                            decorationColor: Colors.pink,
                          ),
                        ),
                        Text(
                          '45,350,000',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                        color: CustomColor.red,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        child: Text(
                          '%3',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColorVariantList extends StatefulWidget {
  List<Variant> variantList;
  ColorVariantList(this.variantList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  List<Widget> colorWidget = [];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantList.length,
          itemBuilder: (context, index) {
            String itemColor = 'ff${widget.variantList[index].value}';
            int hexColor = int.parse(itemColor, radix: 16);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selected = index;
                  });
                },
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    border: (_selected == index)
                        ? Border.all(
                            width: 3,
                            color: Color(hexColor),
                            strokeAlign: BorderSide.strokeAlignOutside,
                          )
                        : Border.all(
                            width: 0.2,
                            color: Colors.white,
                          ),
                    color: Color(hexColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  List<Variant> storageVariantList = [];
  StorageVariantList(this.storageVariantList, {super.key});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  List<Widget> storageWidget = [];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storageVariantList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selected = index;
                  });
                },
                child: Container(
                  height: 25,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                    border: (_selected == index)
                        ? Border.all(
                            width: 2,
                            color: CustomColor.blueIndicator,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          )
                        : Border.all(
                            width: 1,
                            color: CustomColor.gray,
                          ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        widget.storageVariantList[index].value!,
                        style: const TextStyle(fontFamily: 'sb', fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
