import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class LecturerDashboard extends StatelessWidget {
  const LecturerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Giảng Viên'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.qr_code_2_rounded, size: 100, color: Colors.indigo),
              const SizedBox(height: 20),
              const Text('MỞ PHIÊN ĐIỂM DANH QR DÀNH CHO GIẢNG VIÊN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Tọa độ GPS chuẩn phòng A201: (10.762622, 106.660172)'),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Phát Mã QR Điểm Danh Lớp Học'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Mã QR Điểm Danh Lớp HĐH - Nhóm 1'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            color: Colors.black12,
                            child: const Center(child: Icon(Icons.qr_code_2, size: 160, color: Colors.black87)),
                          ),
                          const SizedBox(height: 10),
                          const Text('Mã QR làm mới tự động sau 30s'),
                        ],
                      ),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng'))],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}