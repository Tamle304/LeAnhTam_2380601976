import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../auth/login_screen.dart';
import 'qr_checkin_screen.dart';
import 'face_auth_screen.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sinh Viên: ${UserModel.currentUser?['fullName'] ?? "Lê Anh Tâm"}'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.indigo.shade50,
              child: ListTile(
                leading: const Icon(Icons.badge, size: 40, color: Colors.indigo),
                title: Text(UserModel.currentUser?['fullName'] ?? 'Lê Anh Tâm', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('MSSV: 2380601976 | Lớp: Nhóm 1'),
              ),
            ),
            const SizedBox(height: 20),
            const Text('CHỌN PHƯƠNG THỨC ĐIỂM DANH', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.grey)),
              leading: const Icon(Icons.qr_code_scanner, color: Colors.indigo),
              title: const Text('1. Quét QR Code + Vị trí GPS Geofencing'),
              subtitle: const Text('Yêu cầu đứng cách phòng học dưới 30m'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QrCheckInScreen())),
            ),
            const SizedBox(height: 12),
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.grey)),
              leading: const Icon(Icons.face_retouching_natural, color: Colors.green),
              title: const Text('2. Xác thực khuôn mặt (Face ID)'),
              subtitle: const Text('Nhận diện khuôn mặt sinh viên chính chủ'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FaceAuthScreen())),
            ),
          ],
        ),
      ),
    );
  }
}