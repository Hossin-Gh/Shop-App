class ProductProperties {
  String? id;
  String? productId;
  String? title;
  String? value;
  
  ProductProperties(
    this.id,
    this.productId,
    this.title,
    this.value,
  );

  factory ProductProperties.fromMapJson(Map<String, dynamic> jsonObject) {
    return ProductProperties(
      jsonObject['id'],
      jsonObject['product_id'],
      jsonObject['title'],
      jsonObject['value'],
    );
  }
}
