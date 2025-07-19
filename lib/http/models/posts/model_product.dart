// product_customization_model.dart

class ProductCustomizationModel {
  final String name;
  final int price;
  final String currency;
  final List<String> images;
  final List<String> tags;
  final String? link;
  final List<ProductVariantModel> variants;
  final List<ProductSpecificationModel> specifications;

  ProductCustomizationModel({
    required this.name,
    required this.price,
    required this.currency,
    required this.images,
    required this.tags,
    this.link,
    required this.variants,
    required this.specifications,
  });

  factory ProductCustomizationModel.fromJson(Map<String, dynamic> json) {
    return ProductCustomizationModel(
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      currency: json['currency'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      link: json['link'],
      variants: (json['variants'] as List? ?? [])
          .map((item) => ProductVariantModel.fromJson(item))
          .toList(),
      specifications: (json['specifications'] as List? ?? [])
          .map((item) => ProductSpecificationModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'currency': currency,
      'images': images,
      'tags': tags,
      'link': link,
      'variants': variants.map((v) => v.toJson()).toList(),
      'specifications': specifications.map((s) => s.toJson()).toList(),
    };
  }
}

class ProductVariantModel {
  final String? size;
  final String? color;
  final String? material;
  final String? stone;
  final String? model;
  final int stock;
  final int price;
  final String? sku;

  ProductVariantModel({
    this.size,
    this.color,
    this.material,
    this.stone,
    this.model,
    required this.stock,
    required this.price,
    this.sku,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantModel(
      size: json['size'],
      color: json['color'],
      material: json['material'],
      stone: json['stone'],
      model: json['model'],
      stock: json['stock'] ?? 0,
      price: json['price'] ?? 0,
      sku: json['sku'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'color': color,
      'material': material,
      'stone': stone,
      'model': model,
      'stock': stock,
      'price': price,
      'sku': sku,
    };
  }
}

class ProductSpecificationModel {
  final String? material;
  final String? sole;
  final String? closure;
  final String? battery;
  final String? connectivity;
  final String? features;
  final String? length;

  ProductSpecificationModel({
    this.material,
    this.sole,
    this.closure,
    this.battery,
    this.connectivity,
    this.features,
    this.length,
  });

  factory ProductSpecificationModel.fromJson(Map<String, dynamic> json) {
    return ProductSpecificationModel(
      material: json['material'],
      sole: json['sole'],
      closure: json['closure'],
      battery: json['battery'],
      connectivity: json['connectivity'],
      features: json['features'],
      length: json['length'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'material': material,
      'sole': sole,
      'closure': closure,
      'battery': battery,
      'connectivity': connectivity,
      'features': features,
      'length': length,
    };
  }
}
