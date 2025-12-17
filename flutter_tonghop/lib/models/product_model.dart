class Product {
  final int id;
  final String title;
  final String price;
  final String imageUrl;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  // Chuyển JSON từ Fakestore API thành đối tượng Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Sản phẩm không có tên',
      
      // Fakestore API trả về 'price' là kiểu số (double/int)
      // Chúng ta chuyển nó thành String để hiển thị
      price: json['price'] != null ? json['price'].toString() : '0.00',
      
      // Quan trọng: API trả về key là 'image', ta gán vào biến imageUrl của Model
      // Lưu ý: Link này đã được Service bọc Proxy weserv.nl trước khi đưa vào đây
      imageUrl: json['image'] ?? '', 
    );
  }
}