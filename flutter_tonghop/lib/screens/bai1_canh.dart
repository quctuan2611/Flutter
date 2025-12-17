import 'package:flutter/material.dart';

// Tên của trang này có thể là 'DestinationDetailScreen'
class Bai1Page extends StatelessWidget {
  const Bai1Page({super.key});

  // URL ảnh placeholder. Bạn có thể dán link ảnh của mình vào đây.
  final String imageUrl = 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  @override
  Widget build(BuildContext context) {
    // Scaffold cung cấp cấu trúc cơ bản cho trang
    return Scaffold(
      // App Bar trống để giao diện bắt đầu từ cạnh trên (tùy chọn)
      appBar: AppBar(
        title: const Text('Bài 1 - Classroom'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      // SingleChildScrollView để đảm bảo nội dung có thể cuộn nếu màn hình nhỏ
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. PHẦN ẢNH LỚN
            _buildImageSection(context),

            // 2. PHẦN TIÊU ĐỀ VÀ ĐỊA ĐIỂM
            _buildTitleSection(),

            // 3. PHẦN NÚT HÀNH ĐỘNG (CALL, ROUTE, SHARE)
            _buildButtonSection(context),

            // 4. PHẦN MÔ TẢ CHI TIẾT
            _buildDescriptionSection(),
          ],
        ),
      ),
    );
  }

  // --- WIDGET XÂY DỰNG CÁC PHẦN ---

  // Phần 1: Ảnh
  Widget _buildImageSection(BuildContext context) {
    return Image.network(
      imageUrl,
      width: MediaQuery.of(context).size.width, // Chiều rộng bằng màn hình
      height: 250, // Chiều cao cố định cho ảnh
      fit: BoxFit.cover, // Cắt ảnh để lấp đầy khung
    );
  }

  // Phần 2: Tiêu đề, Địa điểm và Rating
  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Tiêu đề chính
          const Text(
            'Oeschinen Lake Campground',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),

          // Địa điểm và Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Địa điểm
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Kandersteg, Switzerland',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Kandersteg, Switzerland', // Địa điểm lặp lại (theo hình)
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'height: 8', // 'height: 8' (theo hình)
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              
              // Rating (Ngôi sao và số điểm)
              Row(
                children: const <Widget>[
                  Icon(Icons.star, color: Colors.red), // Ngôi sao màu đỏ
                  Text(
                    '41',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Phần 3: Nút hành động
  Widget _buildButtonSection(BuildContext context) {
    // Xây dựng một hàng chứa 3 nút CALL, ROUTE, SHARE
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Nút CALL
          _buildActionColumn(
            color: Colors.blue,
            icon: Icons.phone,
            label: 'CALL',
          ),
          // Nút ROUTE
          _buildActionColumn(
            color: Colors.blue,
            icon: Icons.near_me,
            label: 'ROUTE',
          ),
          // Nút SHARE
          _buildActionColumn(
            color: Colors.blue,
            icon: Icons.share,
            label: 'SHARE',
          ),
          
          // Thêm Rating thứ hai (theo hình)
          Row(
            children: const <Widget>[
              Icon(Icons.star, color: Colors.red), // Ngôi sao màu đỏ
              Text(
                '41',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Hàm tạo Widget cột cho từng nút hành động
  Widget _buildActionColumn({required Color color, required IconData icon, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Giảm kích thước cột
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 28), // Icon
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  // Phần 4: Mô tả chi tiết
  Widget _buildDescriptionSection() {
    const String longDescription =
        'Lake Oeschinen lies at the foot of the Blümlisalp in the Bernese Alps. '
        'Situated 1,578 meters above sea level, it is one of the larger Alpine '
        'Lakes. A gonola ridde from Kandersteg, followed by a half-hour walk '
        'through pastures and pine forest, leads you to the lake, which warms to '
        '20 degrees Celsius Activities enjoyed in colles enjoyed here rowude '
        'rowing, and riding the summer toboggan run.';

    return const Padding(
      padding: EdgeInsets.fromLTRB(32.0, 20.0, 32.0, 32.0),
      child: Text(
        longDescription,
        softWrap: true, // Cho phép xuống dòng
        textAlign: TextAlign.justify, // Căn đều hai bên
        style: TextStyle(
          fontSize: 16.0,
          height: 1.5, // Khoảng cách dòng
        ),
      ),
    );
  }
}