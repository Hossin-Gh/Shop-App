import 'package:flutter_application_1/data/model/variant.dart';
import 'package:flutter_application_1/data/model/variants_type.dart';

class ProductVariants {
  VariantType variantType;
  List<Variant> variantList;

  ProductVariants(
    this.variantType,
    this.variantList,
  );
}
