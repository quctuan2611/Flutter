import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';



class Bai5Page extends StatefulWidget {
  // Xóa 'const' để tránh lỗi nếu các màn hình con không phải là const
  Bai5Page({super.key}); 

  @override
  State<Bai5Page> createState() => _Bai5PageState();
}

class _Bai5PageState extends State<Bai5Page> {
  int _selectedIndex = 0;

  // Danh sách các màn hình con (được định nghĩa bên dưới)
  final List<Widget> _screens = [
    const _ColorChangerScreen(), // Index 0: Đổi Màu
    const _CounterScreen(),      // Index 1: Đếm Số
    _TimerScreen(),             // Index 2: Bộ Đếm Thời Gian (không thể là const)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body hiển thị màn hình con đã chọn
      body: _screens[_selectedIndex],
      
      // Bottom Navigation Bar để chuyển đổi
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.palette),
            label: 'Đổi Màu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exposure_zero),
            label: 'Đếm Số',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Bộ đếm',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}



//Đổi màu
class _ColorChangerScreen extends StatefulWidget {
  const _ColorChangerScreen();

  @override
  State<_ColorChangerScreen> createState() => _ColorChangerScreenState();
}

class _ColorChangerScreenState extends State<_ColorChangerScreen> {
  Color _backgroundColor = Colors.green; // Màu nền ban đầu

  void _changeColor() {
    setState(() {
      // Tạo màu ngẫu nhiên (chỉ định độ trong suốt là FF để màu không bị quá nhạt)
      _backgroundColor = Color(0xFF000000 + Random().nextInt(0xFFFFFFFF));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng dụng Đổi Màu'),
        backgroundColor: _backgroundColor,
        foregroundColor: Colors.white,
      ),
      backgroundColor: _backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Nhấn nút để đổi màu nền!',
              style: TextStyle(fontSize: 20, color: Colors.white, shadows: [
                Shadow(blurRadius: 5.0, color: Colors.black54),
              ]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _changeColor,
              icon: const Icon(Icons.palette),
              label: const Text('Đổi Màu', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//đếm số

class _CounterScreen extends StatefulWidget {
  const _CounterScreen();

  @override
  State<_CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<_CounterScreen> {
  int _counter = 7;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng dụng Đếm Số'),
        backgroundColor: Colors.pink.shade50,
      ),
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Giá trị hiện tại:',
              style: TextStyle(fontSize: 24, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Text(
              '$_counter',
              style: TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Nút Giảm
                ElevatedButton.icon(
                  onPressed: _decrementCounter,
                  icon: const Icon(Icons.remove),
                  label: const Text('Giảm'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
                // Nút Đặt lại
                ElevatedButton.icon(
                  onPressed: _resetCounter,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Đặt lại'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
                // Nút Tăng
                ElevatedButton.icon(
                  onPressed: _incrementCounter,
                  icon: const Icon(Icons.add),
                  label: const Text('Tăng'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Bộ đếm thời gian

class _TimerScreen extends StatefulWidget {
  // Xóa 'const' vì nó chứa logic Timer phức tạp
  _TimerScreen(); 

  @override
  State<_TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<_TimerScreen> {
  static const int _initialTime = 5 * 60; // 5 phút * 60 giây = 300 giây
  int _currentTime = _initialTime;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return;

    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentTime > 0) {
        setState(() {
          _currentTime--;
        });
      } else {
        _timer?.cancel();
        _isRunning = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hết giờ!'), duration: Duration(seconds: 2)),
        );
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _currentTime = _initialTime;
      _isRunning = false;
    });
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ đếm thời gian'),
        backgroundColor: const Color(0xFF3F51B5), 
        foregroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: const Icon(Icons.timer_outlined),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(_currentTime),
              style: const TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F51B5), 
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Nút Bắt đầu
                ElevatedButton.icon(
                  onPressed: _isRunning ? null : _startTimer,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Bắt đầu'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                const SizedBox(width: 20),
                // Nút Đặt lại
                ElevatedButton.icon(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Đặt lại'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}