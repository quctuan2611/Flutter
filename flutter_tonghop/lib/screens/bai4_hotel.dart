import 'package:flutter/material.dart';

class Bai4Page extends StatelessWidget {
  // 1. XÓA 'const' KHỎI CONSTRUCTOR
  // Chỉ còn:
  Bai4Page({super.key});

  // Dữ liệu mô phỏng danh sách phòng/khách sạn
  // 2. XÓA 'const' KHỎI KHAI BÁO LIST
  final List<Map<String, dynamic>> _hotelList = [
    {
      'name': 'aNHill Boutique',
      'rating': 9.5,
      'reviews': 95,
      'distance': '0,6km',
      'price': '109',
      'bedType': '1 suite riêng tư',
      'imagePath': 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'An Nam Hue Boutique',
      'rating': 9.2,
      'reviews': 34,
      'distance': '0,9km',
      'price': '20',
      'bedType': '1 phòng khách sạn',
      'imagePath': 'https://picsum.photos/id/70/150/150',
    },
    {
      'name': 'Hue Jade Hill Villa',
      'rating': 8.0,
      'reviews': 1,
      'distance': '1,3km',
      'price': '285',
      'bedType': '1 biệt thự nguyên căn',
      'imagePath': 'https://picsum.photos/id/80/150/150',
    },
    {
      'name': 'Êm Villa',
      'rating': 7.5,
      'reviews': 12,
      'distance': '1,5km',
      'price': '89',
      'bedType': '1 phòng đôi',
      'imagePath': 'https://picsum.photos/id/90/150/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 1. HEADER (Thanh tìm kiếm và điều hướng)
          _buildHeader(context),

          // 2. THANH SẮP XẾP/LỌC
          _buildFilterBar(),

          // 3. THÔNG BÁO SỐ LƯỢNG KẾT QUẢ
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '757 chỗ nghỉ',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ),
          
          // 4. DANH SÁCH KHÁCH SẠN
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8.0),
              itemCount: _hotelList.length,
              itemBuilder: (context, index) {
                return _buildHotelCard(_hotelList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET XÂY DỰNG CÁC PHẦN ---

  // Phần 1: Header (Thanh điều hướng và ngày tháng)
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
      color: const Color(0xFF1E88E5), // Màu xanh
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.arrow_back, color: Colors.white, size: 24),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Xung quanh vị trí hiện tại',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Text(
                '23 thg 10 – 24 thg 10',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Phần 2: Thanh Sắp xếp, Lọc, Bản đồ
  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterButton('Sắp xếp', Icons.sort, isSelected: true),
          _buildFilterButton('Lọc', Icons.filter_list),
          _buildFilterButton('Bản đồ', Icons.map),
        ],
      ),
    );
  }

  // Widget tạo nút Sắp xếp/Lọc
  Widget _buildFilterButton(String text, IconData icon, {bool isSelected = false}) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: isSelected ? Colors.red : Colors.black87, size: 16),
      label: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.red : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }


  // Phần 4: Thẻ Khách sạn Chi tiết
  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Cột Ảnh và Tag "Bao bữa sáng"
            Stack(
              children: [
                // Ảnh khách sạn (sử dụng Image.network)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    hotel['imagePath'] as String,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                // Tag "Bao bữa sáng"
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Bao bữa sáng',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),

            // 2. Cột Thông tin
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Tên khách sạn và Icon trái tim
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hotel['name'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const Icon(Icons.favorite_border, size: 20, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Rating và Nhận xét
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E88E5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          hotel['rating'].toString(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Xuất sắc - ${hotel['reviews']} đánh giá',
                        style: const TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Vị trí và khoảng cách
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      Text(
                        'Huế - Cách bạn ${hotel['distance']}',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Thông tin phòng
                  Text(
                    '${hotel['bedType']} | 1 giường',
                    style: const TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  
                  // Giá
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          hotel['price'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Text(
                          'Đã bao gồm thuế và phí',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ],
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