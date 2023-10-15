class Banners {
  String? collectionId;
  String? thumbnail;
  String? id;
  String? categoryId;

  Banners(
    this.id,
    this.collectionId,
    this.categoryId,
    this.thumbnail,
  );

  factory Banners.fromMapJson(Map<String, dynamic> jsonObject) {
    return Banners(
      jsonObject['id'],
      jsonObject['collectionId'],
      jsonObject['categoryId'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
