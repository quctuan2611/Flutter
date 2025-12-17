import 'package:dio/dio.dart';
import '../models/product_model.dart'; 

class API {
  Future<List<Product>> getAllProduct() async {
    const String url = 'https://fakestoreapi.com/products';
    final dio = Dio();

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = response.data;

        return list.map((item) {
          // Lấy link ảnh gốc
          String originalUrl = item['image'] ?? "";

          // SỬA LỖI STATUSCODE 0: Bọc Proxy
          item['image'] = "https://images.weserv.nl/?url=${Uri.encodeComponent(originalUrl)}";

          return Product.fromJson(item);
        }).toList();
      } else {
        throw Exception('Lỗi API');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối: $e');
    }
  }
}