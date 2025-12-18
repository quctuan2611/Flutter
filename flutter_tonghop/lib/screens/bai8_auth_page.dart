import 'package:flutter/material.dart';
import 'package:flutter_tonghop/models/user_model.dart';
import 'package:flutter_tonghop/services/auth_service.dart';

class LoginProfileScreen extends StatefulWidget {
  const LoginProfileScreen({super.key});

  @override
  State<LoginProfileScreen> createState() => _LoginProfileScreenState();
}

class _LoginProfileScreenState extends State<LoginProfileScreen> {
  // 1. KHỞI TẠO CÁC ĐIỀU KHIỂN VÀ DỮ LIỆU
  final _userController = TextEditingController(text: 'emilys'); 
  final _passController = TextEditingController(text: 'emilyspass');
  final AuthService _authService = AuthService();

  UserModel? _user;
  bool _isLoading = false;
  String _errorMessage = '';

  // 2. LOGIC XỬ LÝ ĐĂNG NHẬP
  void _onLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final token = await _authService.login(_userController.text, _passController.text);

    if (token != null) {
      final userProfile = await _authService.getProfile(token);
      setState(() {
        _user = userProfile;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Tài khoản hoặc mật khẩu không chính xác!';
      });
    }
  }

  // LOGIC ĐĂNG XUẤT
  void _onLogout() {
    setState(() {
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), 
      appBar: AppBar(
        title: Text(_user == null ? "Đăng Nhập" : "Hồ Sơ Chi Tiết"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          if (_user != null)
            IconButton(onPressed: _onLogout, icon: const Icon(Icons.logout, color: Colors.white))
        ],
      ),
      body: _user == null ? _buildLoginForm() : _buildProfileView(),
    );
  }

  // ==========================================
  // UI 1: FORM ĐĂNG NHẬP
  // ==========================================
  Widget _buildLoginForm() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.lock_person_rounded, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 30),
            TextField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: 'Tài khoản',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white) 
                  : const Text("ĐĂNG NHẬP", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(_errorMessage, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
              ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // UI 2: HỒ SƠ CÁ NHÂN (Đầy đủ thông tin)
  // ==========================================
  Widget _buildProfileView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // HEADER VỚI GRADIENT VÀ AVATAR
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 160,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.indigo],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(_user!.image),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),

          // TÊN VÀ USERNAME
          Text(
            "${_user!.firstName} ${_user!.lastName}",
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            "@${_user!.username}",
            style: TextStyle(fontSize: 14, color: Colors.grey[600], fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 25),

          // DANH SÁCH THÔNG TIN CHI TIẾT THEO TỪNG NHÓM
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- NHÓM 1: LIÊN HỆ ---
                _buildSectionTitle("Thông tin liên hệ"),
                _buildModernInfoCard(Icons.email_rounded, "Email", _user!.email),
                _buildModernInfoCard(Icons.phone_iphone_rounded, "Số điện thoại", _user!.phone),
                
                const SizedBox(height: 20),

                // --- NHÓM 2: CÁ NHÂN ---
                _buildSectionTitle("Thông tin cá nhân"),
                Row(
                  children: [
                    Expanded(child: _buildModernInfoCard(Icons.cake_rounded, "Ngày sinh", _user!.birthDate)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildModernInfoCard(Icons.transgender_rounded, "Giới tính", _user!.gender)),
                  ],
                ),
                _buildModernInfoCard(Icons.location_on_rounded, "Địa chỉ", "${_user!.address}, ${_user!.city}"),

                const SizedBox(height: 20),

                // --- NHÓM 3: CÔNG VIỆC & HỌC VẤN ---
                _buildSectionTitle("Công việc & Học vấn"),
                _buildModernInfoCard(Icons.business_center_rounded, "Chức danh", _user!.jobTitle),
                _buildModernInfoCard(Icons.apartment_rounded, "Công ty", _user!.companyName),
                _buildModernInfoCard(Icons.school_rounded, "Đại học", _user!.university),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET TIÊU ĐỀ TỪNG PHẦN
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }

  // WIDGET THẺ THÔNG TIN HIỆN ĐẠI
  Widget _buildModernInfoCard(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blueAccent, size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(
                  value.isEmpty ? "Chưa cập nhật" : value, 
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}