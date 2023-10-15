// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widget/banner_slider.dart';
import 'package:flutter_application_1/Widget/category_item.dart';
import 'package:flutter_application_1/Widget/product_item.dart';
import 'package:flutter_application_1/bloc/home/home_bloc.dart';
import 'package:flutter_application_1/bloc/home/home_event.dart';
import 'package:flutter_application_1/bloc/home/home_state.dart';
import 'package:flutter_application_1/constans/colors.dart';
import 'package:flutter_application_1/data/model/banner.dart';
import 'package:flutter_application_1/data/model/category.dart';
import 'package:flutter_application_1/data/model/product.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScr extends StatefulWidget {
  const HomeScr({super.key});

  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  get gray => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeRequestList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScr,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state is HomeLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                } else ...{
                  const _getSearchBox(),
                  //
                  //banner
                  //
                  if (state is HomeResponseState) ...[
                    state.response.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (r) {
                        return _GetBanner(r);
                      },
                    ),
                  ],
                  //
                  //category
                  //
                  const _GetCategoryTitle(),
                  if (state is HomeResponseState) ...[
                    state.categoryList.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      },
                      (categoryList) {
                        return _getCategoryLists(categoryList);
                      },
                    )
                  ],
                  //
                  //basts Sell Item
                  //
                  const _getBestSellTitle(),
                  if (state is HomeResponseState) ...[
                    state.bestSellerProductsList.fold((exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      );
                    }, (list) {
                      return _getBestSellProducts(list);
                    })
                  ],
                  //
                  //most view Item
                  //
                  const _getMostViewedTitle(),
                  if (state is HomeResponseState) ...[
                    state.hotestProductsList.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      },
                      (list) {
                        return _getMostViewedProducts(list);
                      },
                    )
                  ],
                },
              ],
            );
          },
        ),
      ),
    );
  }
}

class _getMostViewedProducts extends StatelessWidget {
  List<Product> hotestProductList;
  _getMostViewedProducts(
    this.hotestProductList, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(hotestProductList[index]),
              );
            },
            itemCount: hotestProductList.length,
          ),
        ),
      ),
    );
  }
}

class _getMostViewedTitle extends StatelessWidget {
  const _getMostViewedTitle();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, bottom: 20, top: 32),
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Image.asset('assets/images/icon_left_categroy.png'),
            ),
            const SizedBox(width: 10),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                  fontFamily: 'SB', fontSize: 12, color: CustomColor.blue),
            ),
            const Spacer(),
            const Text(
              'پر بازدید ترین ها',
              style: TextStyle(
                  fontFamily: 'SB', fontSize: 12, color: CustomColor.gray),
            ),
          ],
        ),
      ),
    );
  }
}

class _getBestSellProducts extends StatelessWidget {
  List<Product> productList;
  _getBestSellProducts(
    this.productList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(productList[index]),
              );
            },
            itemCount: productList.length,
          ),
        ),
      ),
    );
  }
}

class _getBestSellTitle extends StatelessWidget {
  const _getBestSellTitle();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Image.asset('assets/images/icon_left_categroy.png'),
            ),
            const SizedBox(width: 10),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                  fontFamily: 'SB', fontSize: 12, color: CustomColor.blue),
            ),
            const Spacer(),
            const Text(
              'پر فروش ترین ها',
              style: TextStyle(
                  fontFamily: 'SB', fontSize: 12, color: CustomColor.gray),
            ),
          ],
        ),
      ),
    );
  }
}

class _getCategoryLists extends StatefulWidget {
  List<Category> listCategories;
  _getCategoryLists(
    this.listCategories, {
    Key? key,
  }) : super(key: key);

  @override
  State<_getCategoryLists> createState() => _getCategoryListsState();
}

class _getCategoryListsState extends State<_getCategoryLists> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 90,
          child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CategoryItemChip(
                  widget.listCategories[index],
                ),
              );
            },
            itemCount: widget.listCategories.length,
          ),
        ),
      ),
    );
  }
}

class _GetCategoryTitle extends StatelessWidget {
  const _GetCategoryTitle();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 44, top: 10, bottom: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'دسته بندی',
            style: TextStyle(color: CustomColor.gray, fontFamily: 'SM'),
          ),
        ),
      ),
    );
  }
}

class _GetBanner extends StatelessWidget {
  List<Banners> list;
  _GetBanner(this.list);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(list),
    );
  }
}

class _getSearchBox extends StatelessWidget {
  const _getSearchBox();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, top: 10, bottom: 34),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset('assets/images/icon_apple_blue.png'),
                const Spacer(),
                const Text(
                  'جوستجو محصولات',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: CustomColor.gray,
                    fontFamily: 'SB',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset('assets/images/icon_search.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
