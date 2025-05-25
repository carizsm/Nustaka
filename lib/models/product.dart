// models/product.dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final List<String> images;
  // ... tambahkan field lain sesuai interface ProductWithId Anda
  // final String sellerId;
  // final String categoryId;
  // final String regionId;
  // final String status;
  // final DateTime createdAt; // Perlu parsing khusus dari String ke DateTime
  // final DateTime? updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.images,
    // ...
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(), // Pastikan konversi tipe aman
      stock: json['stock'] as int,
      images: List<String>.from(json['images'] as List),
      // createdAt: DateTime.parse(json['created_at'] as String), // Contoh parsing tanggal
      // ... parsing field lain
    );
  }
}

// Jika ada sellerInfo dan reviewSummary seperti diskusi kita:
class SellerInfo {
  final String id;
  final String username;
  SellerInfo({required this.id, required this.username});
  factory SellerInfo.fromJson(Map<String, dynamic> json) {
    return SellerInfo(id: json['id'], username: json['username']);
  }
}

class ReviewSummary {
  final double? averageRating;
  final int reviewCount;
  ReviewSummary({this.averageRating, required this.reviewCount});
  factory ReviewSummary.fromJson(Map<String, dynamic> json) {
    return ReviewSummary(
        averageRating: (json['averageRating'] as num?)?.toDouble(),
        reviewCount: json['reviewCount'] as int
    );
  }
}

class FullyEnrichedProduct extends Product {
  final SellerInfo? sellerInfo;
  final ReviewSummary? reviewSummary;
  // ... tambahkan field history jika ada

  FullyEnrichedProduct({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.stock,
    required super.images,
    this.sellerInfo,
    this.reviewSummary,
    // ...
  });

  factory FullyEnrichedProduct.fromJson(Map<String, dynamic> json) {
    return FullyEnrichedProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int,
      images: List<String>.from(json['images'] as List),
      sellerInfo: json['sellerInfo'] != null ? SellerInfo.fromJson(json['sellerInfo']) : null,
      reviewSummary: json['reviewSummary'] != null ? ReviewSummary.fromJson(json['reviewSummary']) : null,
      // ...
    );
  }
}