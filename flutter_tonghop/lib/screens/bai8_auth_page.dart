import 'package:flutter/material.dart';
import 'package:flutter_tonghop/models/user_model.dart';
import 'package:flutter_tonghop/services/auth_service.dart';

class LoginProfileScreen extends StatefulWidget {
  const LoginProfileScreen({super.key});

  @override
  State<LoginProfileScreen> createState() => _LoginProfileScreenState();
}

class _LoginProfileScreenState extends State<LoginProfileScreen> {
  final _userController = TextEditingController(text: 'emilys');
  final _passController = TextEditingController(text: 'emilyspass');
  final AuthService _authService = AuthService();

  UserModel? _user;
  bool _isLoading = false;
  String _errorMessage = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user == null ? "Đăng Nhập" : "Hồ Sơ"),
        backgroundColor: Colors.blueAccent,
        actions: [
          if (_user != null)
            IconButton(onPressed: () => setState(() => _user = null), icon: const Icon(Icons.logout))
        ],
      ),
      body: _user == null ? _buildLoginForm() : _buildProfileView(),
    );
  }

  // --- UI FORM ĐĂNG NHẬP ---
  Widget _buildLoginForm() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.lock_person, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 30),
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'Tài khoản', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mật khẩu', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _onLogin,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("ĐĂNG NHẬP", style: TextStyle(color: Colors.white)),
              ),
            ),
            if (_errorMessage.isNotEmpty) Text(_errorMessage, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  // --- UI THÔNG TIN CÁ NHÂN ---
  Widget _buildProfileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(radius: 60, backgroundImage: NetworkImage(_user!.image)),
          const SizedBox(height: 10),
          Text("${_user!.firstName} ${_user!.lastName}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                _infoTile(Icons.email, "Email", _user!.email),
                _infoTile(Icons.phone, "SĐT", _user!.phone),
                _infoTile(Icons.location_city, "Thành phố", _user!.city),
                _infoTile(Icons.work, "Công việc", _user!.jobTitle),
                _infoTile(Icons.school, "Đại học", _user!.university),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}