import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/model/category.dart';
import 'package:flutter_application_1/data/model/product_image.dart';
import 'package:flutter_application_1/data/model/product_properties.dart';
import 'package:flutter_application_1/data/model/product_variant.dart';
import 'package:flutter_application_1/data/model/variant.dart';
import 'package:flutter_application_1/data/model/variants_type.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/util/api_exception.dart';

abstract class IProductDetailDatasource {
  Future<List<ProductImage>> getGallery(String productId);
  Future<List<VariantType>> getVariantType();
  Future<List<Variant>> getVariant(String productId);
  Future<List<ProductVariants>> getProductVariants(String productId);
  Future<Category> getProductCatrgory(String categoryId);
  Future<List<ProductProperties>> getProductProperties(String productId);
}

class DetailProductDatasource extends IProductDetailDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    try {
      Map<String, String> queryParams = {'filter': 'product_id="$productId"'};
      var respones = await _dio.get(
        'collections/gallery/records',
        queryParameters: queryParams,
      );
      return respones.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unlnown erorr');
    }
  }

  @override
  Future<List<VariantType>> getVariantType() async {
    try {
      var respones = await _dio.get('collections/variants_type/records');

      return respones.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unlnown erorr');
    }
  }

  @override
  Future<List<Variant>> getVariant(String productId) async {
    try {
      Map<String, String> queryParams = {'filter': 'product_id="$productId"'};

      var respones = await _dio.get(
        'collections/variants/records',
        queryParameters: queryParams,
      );

      return respones.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unlnown erorr');
    }
  }

  @override
  Future<List<ProductVariants>> getProductVariants(String productId) async {
    var variantTypeList = await getVariantType();
    var variantList = await getVariant(productId);

    List<ProductVariants> productVariantList = [];

    try {
      for (var variantType in variantTypeList) {
        var listVariant = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();

        productVariantList.add(ProductVariants(variantType, listVariant));
      }

      return productVariantList;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unlnown erorr');
    }
  }

  @override
  Future<Category> getProductCatrgory(String categoryId) async {
    try {
      Map<String, String> queryParams = {'filter': 'id="$categoryId"'};

      var respones = await _dio.get(
        'collections/category/records',
        queryParameters: queryParams,
      );

      return Category.fromMapJson(respones.data['items'][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unlnown erorr');
    }
  }

  @override
  Future<List<ProductProperties>> getProductProperties(String productId) async {
    try {
      Map<String, String> queryParams = {'filter': 'product_id="$productId"'};
      var response = await _dio.get(
        'collections/properties/records',
        queryParameters: queryParams,
      );
       return response.data['items']
          .map<ProductProperties>((jsonObject) => ProductProperties.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unlnown erorr');
    }
  }
}
