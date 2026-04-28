class ProductModel {

  final String id;
  final String title;
  final int currentPrice;
  final double rating;
  final List<String>  images;

  ProductModel({
    required this.id,
    required this.title,
    required this.currentPrice,
    required this.rating,
    required this.images,
  });

  // Convert from Json to Object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      title: json['title'],
      currentPrice: json['current_price'],
      rating: json['rating'] ?? 4.0,
      images: List.from(json['photos']),
      // images: (json['photos'] as List? ?? []).cast<String>(), // নাল এবং টাইপ চেক
      // photos নাল হতে পারে বা খালি হতে পারে, তাই এভাবে ম্যাপ করা ভালো
     // images: (json['photos'] as List? ?? []).map((e) => e.toString()).toList(),
    );
  }
}