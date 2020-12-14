class ProductImage {
  ProductImage({
    this.id,
    this.url,
    this.productId,
    this.createdAt,
    this.createdBy,
    this.updatedBy,
    this.updatedAt,
  });

  String id;
  String url;
  String productId;
  DateTime createdAt;
  String createdBy;
  dynamic updatedBy;
  dynamic updatedAt;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        url: json["url"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "product_id": productId,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "updated_at": updatedAt,
      };
}
