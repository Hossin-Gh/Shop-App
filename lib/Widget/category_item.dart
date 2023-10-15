import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widget/cached_image.dart';
import 'package:flutter_application_1/bloc/categoryProduct/category_product_bloc.dart';
import 'package:flutter_application_1/data/model/category.dart';
import 'package:flutter_application_1/screens/products_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItemChip extends StatelessWidget {
  final Category category;
  const CategoryItemChip(
    this.category, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'FF${category.color}';
    var hexColor = int.parse(categoryColor, radix: 16);
    return GestureDetector(onTap:() {
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: ((context) => CategoryProductBloc()),
              child: ProductsScr(category),
            ),
          ),
        );
    },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  shadows: [
                    BoxShadow(
                      color: Color(hexColor),
                      blurRadius: 20,
                      spreadRadius: -13,
                      offset: const Offset(0, 15),
                    ),
                  ],
                  color: Color(hexColor),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: CachedImageWidget(imageURL: category.icon!),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            category.title ?? 'محصول',
            style: const TextStyle(
              fontFamily: 'SB',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
