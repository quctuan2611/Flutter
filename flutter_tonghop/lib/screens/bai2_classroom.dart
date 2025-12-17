import 'package:flutter/material.dart';

class Bai2Page extends StatelessWidget {
  const Bai2Page({super.key});

  // Dữ liệu mô phỏng danh sách khóa học/phòng khách sạn
  final List<Map<String, dynamic>> _hotelData = const [
    {
      'title': 'XML và ứng dụng - Nhóm 1',
      'subtitle': '2025-2026.1.TIN4583.001',
      'footer': '58 học viên',
      'color': Color(0xFF5E35B1), 
      // URL Ảnh Demo 1
      'imageUrl': 'https://picsum.photos/id/10/400/200',
    },
    {
      'title': 'Lập trình ứng dụng cho các t...',
      'subtitle': '2025-2026.1.TIN4403.006',
      'footer': '55 học viên',
      'color': Color(0xFFD32F2F), 
      // URL Ảnh Demo 2
      'imageUrl': 'https://picsum.photos/id/20/400/200',
    },
    {
      'title': 'Lập trình ứng dụng cho các t...',
      'subtitle': '2025-2026.1.TIN4403.005',
      'footer': '52 học viên',
      'color': Color(0xFFE64A19), 
      // URL Ảnh Demo 3
      'imageUrl': 'https://picsum.photos/id/30/400/200',
    },
    {
      'title': 'Lập trình ứng dụng cho các t...',
      'subtitle': '2025-2026.1.TIN4403.004',
      'footer': '50 học viên',
      'color': Color(0xFF1976D2), 
      // URL Ảnh Demo 4
      'imageUrl': 'https://picsum.photos/id/40/400/200',
    },
    {
      'title': 'Lập trình ứng dụng cho các t...',
      'subtitle': '2025-2026.1.TIN4403.003',
      'footer': '52 học viên',
      'color': Color(0xFF00796B), 
      // URL Ảnh Demo 5
      'imageUrl': 'https://picsum.photos/id/50/400/200',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 2 - Classroom'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _hotelData.length,
        itemBuilder: (context, index) {
          final item = _hotelData[index];
          return _buildCourseCard(
            title: item['title'] as String,
            subtitle: item['subtitle'] as String,
            footer: item['footer'] as String,
            color: item['color'] as Color,
            imageUrl: item['imageUrl'] as String, // Truyền URL vào widget
          );
        },
      ),
    );
  }

  // Widget xây dựng từng thẻ (Card) khóa học/khách sạn
  Widget _buildCourseCard({
    required String title,
    required String subtitle,
    required String footer,
    required Color color,
    required String imageUrl, // Nhận URL thay vì asset path
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 140, 
        decoration: BoxDecoration(
          color: color, 
        ),
        child: Stack(
          children: <Widget>[
            // 1. Hình nền (Sử dụng Image.network)
            Image.network(
              imageUrl, // Sử dụng URL ảnh
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              
              // Thêm hiệu ứng loading khi ảnh đang tải (tùy chọn)
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                    color: Colors.white70,
                  ),
                );
              },
              
              // Thêm lớp phủ nhẹ để text dễ đọc hơn (Blur effect không phải là BlendMode)
              // Ta sẽ dùng BlendMode để làm tối ảnh
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),

            // 2. Nội dung text và menu
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Hàng trên cùng: Tiêu đề và nút ba chấm
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.more_vert, color: Colors.white),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Dòng phụ
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const Spacer(), 

                  // Phần footer
                  Text(
                    footer,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}