import 'package:flutter/material.dart';

// --- PHẦN IMPORT ĐÃ ĐƯỢC SỬA ---
import 'mainpage.dart';          // Chứa MainContentPage
import 'bai1_canh.dart';       
import 'bai2_classroom.dart';
import 'bai3_hellocharlie.dart';
import 'bai4_hotel.dart';
import 'bai5.dart';
import 'bai6_shoppe.dart'; 
import 'bai7_newlist.dart';     
import 'bai8_auth_page.dart'; 
import 'bai9_login.dart'; 


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _menuItems = [
    {'title': 'Mainpage', 'icon': Icons.home},
    {'title': 'Bài 1 - Phong cảnh', 'icon': Icons.travel_explore},
    {'title': 'Bài 2 - Classroom', 'icon': Icons.class_},
    {'title': 'Bài 3 - welcome charlie', 'icon': Icons.list},
    {'title': 'Bài 4 - hotel', 'icon': Icons.hotel},
    {'title': 'Bài 5 - Đếm số', 'icon': Icons.timer},
    {'title': 'Bài 6 - shoppe', 'icon': Icons.shopping_cart},
    {'title': 'Bài 7 - News List', 'icon': Icons.list_alt},
    {'title': 'Bài 8 - Thông tin cá nhân', 'icon': Icons.person_outline}, 
    {'title': 'Bài 9 - Đăng nhập', 'icon': Icons.login},
  ];

  //CẬP NHẬT DANH SÁCH TRANG
  final List<Widget> _pages = [
    const MainContentPage(), 
    const Bai1Page(),        
    const Bai2Page(),
    const Bai3Page(),
    Bai4Page(),              // Bỏ const nếu class này không có const constructor
    Bai5Page(),              
    const Bai6Page(),   
    const NewsListPage(), 
    const LoginProfileScreen(),   
    const Bai9Screen(),   
  ];

  void _onMenuItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        // Đảm bảo icon menu có màu đen để nổi bật trên nền trắng
        iconTheme: const IconThemeData(color: Colors.black), 
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      drawer: Drawer(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50.0),
          ),
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildDrawerHeader(),
                ..._menuItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> item = entry.value;

                  return _buildMenuItem(
                    icon: item['icon'] as IconData,
                    title: item['title'] as String,
                    index: index,
                    isSelected: index == _selectedIndex,
                    onTap: () => _onMenuItemTap(index),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 10, 183, 196),
      ),
      child: Row(
        children: const <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: Icon(Icons.school, color: Color.fromARGB(255, 10, 183, 196), size: 30),
          ),
          SizedBox(width: 15),
          Text(
            'Danh mục bài tập',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final color = isSelected ? const Color.fromARGB(255, 10, 183, 196) : Colors.black87;
    final backgroundColor = isSelected ? const Color.fromARGB(30, 10, 183, 196) : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: backgroundColor,
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(color: color, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
        onTap: onTap,
      ),
    );
  }
}