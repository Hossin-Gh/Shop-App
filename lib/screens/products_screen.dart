import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/categoryProduct/category_product_bloc.dart';
import 'package:flutter_application_1/bloc/categoryProduct/category_product_event.dart';
import 'package:flutter_application_1/bloc/categoryProduct/category_product_state.dart';
import 'package:flutter_application_1/constans/colors.dart';
import 'package:flutter_application_1/data/model/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widget/product_item.dart';

class ProductsScr extends StatefulWidget {
  Category category;
  ProductsScr(this.category, {super.key});

  @override
  State<ProductsScr> createState() => _ProductsScrState();
}

class _ProductsScrState extends State<ProductsScr> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductInitialize(widget.category.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CustomColor.backgroundScr,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is CategoryProdcutloadingState) ...{
                  const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                } else ...{
                  _AppBar(widget: widget),
                  if (state is CategoryProductResopnseSuccessState) ...{
                    state.productListByCatrgoryId.fold(
                      (l) {
                        return SliverToBoxAdapter(child: Text(l));
                      },
                      (productList) {
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 44),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return ProductItem(
                                  productList[index],
                                );
                              },
                              childCount: productList.length,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 30,
                              childAspectRatio: 2 / 2.8,
                              crossAxisSpacing: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  },
                },
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.widget,
  });

  final ProductsScr widget;

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/icon_apple_blue.png'),
                Text(
                  widget.category.title!,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
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
    );
  }
}
