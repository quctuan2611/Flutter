import 'package:flutter/material.dart';

class Bai9Screen extends StatefulWidget {
  const Bai9Screen({super.key});

  @override
  State<Bai9Screen> createState() => _Bai9ScreenState();
}

class _Bai9ScreenState extends State<Bai9Screen> {
  // 1. Tạo GlobalKey để quản lý trạng thái của Form
  final _formKey = GlobalKey<FormState>();
  bool _isLoginView = true;

  // Hàm xử lý khi nhấn nút Đăng nhập/Đăng ký
  void _submitData() {
    // 2. Kích hoạt logic kiểm tra của tất cả các TextFormField trong Form
    if (_formKey.currentState!.validate()) {
      // Nếu dữ liệu hợp lệ (không trống)
      print("Dữ liệu hợp lệ!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginView ? "Form Đăng nhập" : "Form Đăng ký tài khoản"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // 3. Gán key vào Form
          child: Column(
            children: [
              const SizedBox(height: 20),
              _isLoginView ? _buildLoginForm() : _buildRegisterForm(),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoginView = !_isLoginView;
                    // Reset lỗi khi chuyển màn hình
                    _formKey.currentState?.reset();
                  });
                },
                child: Text(
                  _isLoginView
                      ? "Chưa có tài khoản? Đăng ký ngay"
                      : "Đã có tài khoản? Đăng nhập",
                  style: const TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        _buildInputField(Icons.person, "Tên người dùng", "Tên người dùng không được để trống"),
        const SizedBox(height: 20),
        _buildInputField(Icons.lock, "Mật khẩu", "Mật khẩu không được để trống", isPassword: true),
        const SizedBox(height: 30),
        _buildMainButton(Icons.login, "Đăng nhập"),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      children: [
        _buildInputField(Icons.person_outline, "Họ tên", "Họ tên không được để trống"),
        const SizedBox(height: 15),
        _buildInputField(Icons.email_outlined, "Email", "Email không được để trống"),
        const SizedBox(height: 15),
        _buildInputField(Icons.lock_outline, "Mật khẩu", "Mật khẩu không được để trống", isPassword: true),
        const SizedBox(height: 15),
        _buildInputField(Icons.verified_user_outlined, "Xác nhận mật khẩu", "Xác nhận mật khẩu không được để trống", isPassword: true),
        const SizedBox(height: 30),
        _buildMainButton(Icons.group_add, "Đăng ký"),
      ],
    );
  }

  // --- THAY ĐỔI CHÍNH Ở ĐÂY ---
  Widget _buildInputField(IconData icon, String label, String errorText, {bool isPassword = false}) {
    return TextFormField( // Dùng TextFormField để có tính năng validate
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        labelText: label,
        // Khi bình thường, viền sẽ có màu xám hoặc màu chủ đạo
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueGrey, width: 1),
        ),
        // Khi có lỗi, viền sẽ tự động chuyển sang màu đỏ
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
      // Logic kiểm tra: Nếu trả về String khác null, nó sẽ hiện lỗi đó
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }

  Widget _buildMainButton(IconData icon, String text) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: _submitData, // Gọi hàm validate khi nhấn nút
        icon: Icon(icon),
        label: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF1F3F9),
          foregroundColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
      ),
    );
  }
}