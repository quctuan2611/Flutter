import 'package:flutter/material.dart';

class MainContentPage extends StatelessWidget {
  const MainContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Màu nền trắng khói cực kỳ dịu mắt
      backgroundColor: const Color(0xFFF8F9FA), 
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Biểu tượng giáo dục (Tạo điểm nhấn phía trên)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_stories_outlined, // Icon quyển sách mở
                    size: 40,
                    color: Color(0xFF2D3436),
                  ),
                ),
                const SizedBox(height: 30),

                // 2. Card thông tin chính
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24), // Bo góc tròn hơn cho hiện đại
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      // Tên sinh viên - Chữ đậm, dãn cách đẹp
                      const Text(
                        'TRAN QUOC TUAN',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2D3436),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Mã số sinh viên dạng Tag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F3F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'MSSV: 22T1020789',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF636E72),
                          ),
                        ),
                      ),
                      
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                        child: Divider(thickness: 0.5, color: Colors.grey),
                      ),

                      // Thông tin chi tiết với helper widget bên dưới
                      _buildInfoRow(Icons.layers_outlined, 'Lập trình ứng dụng di động'),
                      _buildInfoRow(Icons.api_outlined, 'Nhóm 5 - Flutter Project'),
                      _buildInfoRow(Icons.school_outlined, 'Thầy Nguyễn Dũng'),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                
                // 3. Footer nhỏ (Dòng chữ bản quyền hoặc năm học nhẹ nhàng)
                const SizedBox(height: 30),
                const Text(
                  '© 2025 Mobile App Course',
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget con để hiển thị các dòng thông tin có icon
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 35, right: 35),
      child: Row(
        children: [
          Icon(icon, size: 22, color: const Color(0xFF0984E3)), // Màu xanh thanh lịch
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF495057),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}