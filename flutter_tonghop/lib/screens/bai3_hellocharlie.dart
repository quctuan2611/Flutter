import 'package:flutter/material.dart';

// --- 1. Định nghĩa Model (Mô hình Dữ liệu) ---
// Model đơn giản để chứa đường dẫn ảnh cho các địa điểm
class Place {
  final String assetPath;
  const Place(this.assetPath); 
}

// --- 2. Lớp Màn hình Bài 3 (ĐÃ ĐỔI TÊN TỪ HomeScreen) ---
class Bai3Page extends StatelessWidget { // ĐÃ ĐỔI TÊN TẠI ĐÂY
  const Bai3Page({super.key});

  // Dữ liệu giả (mock data) cho phần Saved Places
  // Lưu ý: Đường dẫn ảnh là 'assets/images/anhX.png'
  final List<Place> savedPlaces = const [
    Place('assets/anh1.png'), 
    Place('assets/anh2.png'),
    Place('assets/anh3.png'), 
    Place('assets/anh4.png'), 
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold cung cấp cấu trúc cơ bản cho màn hình
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      // SafeArea đảm bảo nội dung không bị che bởi thanh trạng thái
      body: SafeArea(
        // SingleChildScrollView cho phép cuộn khi nội dung quá dài
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            // Column xếp các widget theo chiều dọc
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // --- 2.1. Thanh Icons (Thông báo & Cài đặt) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.notifications_none, size: 28.0, color: Colors.black87),
                      onPressed: () {},
                    ),
                    // Thay thế Icon Settings (cài đặt) bằng Icon Star (theo hình mẫu)
                    IconButton(
                      icon: const Icon(Icons.star_border, size: 28.0, color: Colors.black87), 
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 30.0), 

                // --- 2.2. Tiêu đề Chào mừng (Welcome, Charlie) ---
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 34.0, 
                      color: Colors.black,
                      height: 1.1,
                    ),
                    children: <TextSpan>[
                      // "Welcome," - Đã sửa lại để trông giống hình mẫu hơn (không in đậm)
                      TextSpan(
                        text: 'Welcome,\n',
                        style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black54),
                      ),
                      // "Charlie" - In đậm
                      TextSpan(
                        text: 'Charlie',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Đã điều chỉnh in đậm
                          fontSize: 40.0, // Đã điều chỉnh cỡ chữ
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0), 

                // --- 2.3. Thanh Tìm kiếm (Search Bar) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.blue.shade200, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.05),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), 
                        ),
                      ]
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.blue), // Màu xanh theo mẫu
                        border: InputBorder.none, 
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0), 

                // --- 2.4. Tiêu đề Saved Places ---
                const Text(
                  'Saved Places',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20.0), 

                // --- 2.5. GridView (Danh sách ảnh) ---
                GridView.builder(
                  shrinkWrap: true, 
                  physics: const NeverScrollableScrollPhysics(), 
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 15.0, 
                    mainAxisSpacing: 15.0, 
                    childAspectRatio: 1.2, // Điều chỉnh tỷ lệ để phù hợp với hình mẫu
                  ),
                  itemCount: savedPlaces.length,
                  itemBuilder: (context, index) {
                    final place = savedPlaces[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        place.assetPath,
                        fit: BoxFit.cover, 
                        alignment: Alignment.center, 
                        // Thêm errorBuilder để dễ dàng tìm lỗi nếu ảnh không hiện
                        errorBuilder: (context, error, stackTrace) {
                           return Container(
                              color: Colors.red.shade100,
                              child: Center(
                                child: Text('LỖI: Thiếu ảnh\n${place.assetPath}', 
                                textAlign: TextAlign.center, 
                                style: const TextStyle(fontSize: 10, color: Colors.red)),
                              ),
                           );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}