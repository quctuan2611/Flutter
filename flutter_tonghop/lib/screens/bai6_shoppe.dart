import 'package:flutter/material.dart';
import '../services/product_service.dart'; // Đảm bảo đúng tên file service của bạn
import '../models/product_model.dart';

class Bai6Page extends StatefulWidget {
  const Bai6Page({super.key});

  @override
  State<Bai6Page> createState() => _Bai6PageState();
}

class _Bai6PageState extends State<Bai6Page> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    // ĐÃ SỬA: Gọi đúng Class API() và hàm getAllProduct() bạn vừa tạo
    _futureProducts = API().getAllProduct(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // Đưa FutureBuilder ra ngoài để quản lý trạng thái tải của toàn bộ trang
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepOrange));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 40),
                  Text('Lỗi: ${snapshot.error}'),
                  TextButton(
                    onPressed: () => setState(() { _futureProducts = API().getAllProduct(); }),
                    child: const Text("Thử lại"),
                  )
                ],
              ),
            );
          }

          final products = snapshot.data ?? [];
          
          return CustomScrollView(
            slivers: [
              _buildSimpleAppBar(),
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.72, // Điều chỉnh một chút để tránh tràn chữ (Overflow)
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildItemCard(products[index]),
                    childCount: products.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItemCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, spreadRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần hình ảnh
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
              child: Image.network(
                // Lưu ý: Link ảnh đã được xử lý Proxy bên trong ProductService rồi 
                // nên ở đây ta chỉ cần gọi trực tiếp.
                product.imageUrl,
                fit: BoxFit.contain,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => 
                  const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                },
              ),
            ),
          ),
          // Phần thông tin chữ
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, height: 1.3),
                ),
                const SizedBox(height: 8),
                Text(
                  "₫${product.price}", // Bạn có thể dùng \$ nếu thích
                  style: const TextStyle(
                    color: Colors.deepOrange, 
                    fontSize: 16, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: true, // Giữ thanh tìm kiếm khi cuộn
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: Container(
        height: 38,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Row(
          children: [
            SizedBox(width: 10),
            Icon(Icons.search, color: Colors.deepOrange, size: 20),
            SizedBox(width: 10),
            Text("Tìm trên Shopee", style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
      ),
      actions: const [
        Icon(Icons.shopping_cart_outlined, color: Colors.deepOrange),
        SizedBox(width: 15),
      ],
    );
  }
}