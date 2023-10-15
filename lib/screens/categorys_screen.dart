import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widget/cached_image.dart';
import 'package:flutter_application_1/bloc/category/category_bloc.dart';
import 'package:flutter_application_1/bloc/category/category_event.dart';
import 'package:flutter_application_1/bloc/category/category_state.dart';
import 'package:flutter_application_1/constans/colors.dart';
import 'package:flutter_application_1/data/model/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScr extends StatefulWidget {
  const CategoryScr({super.key});

  @override
  State<CategoryScr> createState() => _CategoryScrState();
}

class _CategoryScrState extends State<CategoryScr> {
  List<Category> list = [];
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScr,
      body: SafeArea(
        child: CustomScrollView(
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
                        Image.asset('assets/images/icon_apple_blue.png'),
                        const Text(
                          'دسته بندی',
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
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is CategoryResponseState) {
                  return state.response.fold((l) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(l)),
                    );
                  }, (r) {
                    return _listCategory(
                      list: r,
                    );
                  });
                }
                return const SliverToBoxAdapter(
                  child: Text('error'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _listCategory extends StatelessWidget {
  List<Category> list;

  _listCategory({
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CachedImageWidget(imageURL: list[index].thumbnail ?? 'test');
          },
          childCount: list.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
