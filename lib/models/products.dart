class Product {
  final String title;
  final String image;
  final double price;
  final String category;
  final String desc;
  final String createdAt;

  Product({
    required this.title,
    required this.image,
    required this.price,
    required this.category,
    required this.desc,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'price': price,
      'category': category,
      'desc': desc,
      'createdAt': createdAt,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'] ?? "",
      image: map['image'] ?? "",
      price: map['price'] as double,
      category: map['category'] ?? "",
      desc: map['desc'] ?? "",
      createdAt: map['createdAt'] ?? "",
    );
  }
}
