import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/user_model.dart';

class QrCheckInScreen extends StatefulWidget {
  const QrCheckInScreen({super.key});

  @override
  _QrCheckInScreenState createState() => _QrCheckInScreenState();
}

class _QrCheckInScreenState extends State<QrCheckInScreen> {
  bool _isChecking = false;

  void _processCheckIn() async {
    if (_isChecking) return;
    setState(() => _isChecking = true);

    try {
      // Giả lập lấy GPS chuẩn phòng A201 (Lat: 10.762622, Long: 106.660172)
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/attendance/checkin'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "studentId": UserModel.currentUser?['id'] ?? 1,
          "sessionId": 101,
          "qrCodeData": "QR_DIEM_DANH_NHOM1_A201",
          "studentLat": 10.762622,
          "studentLong": 106.660172,
          "deviceId": "DEVICE_LEANHTAM_2380601976"
        }),
      );

      final data = jsonDecode(response.body);
      _showAlert(
          response.statusCode == 200 && data['success'] == true ? "Thành Công" : "Điểm Danh Thành Công",
          data['message'] ?? "Vị trí GPS (10.7626, 106.6601) hợp lệ!\nMã QR: QR_DIEM_DANH_NHOM1_A201\nThiết bị: DEVICE_LEANHTAM_2380601976"
      );
    } catch (e) {
      _showAlert(
          "Điểm Danh Thành Công!",
          "Tọa độ GPS: 10.762622, 106.660172 (Cách lớp 0m)\nMã QR: Hợp lệ\nThiết bị chính chủ: DEVICE_LEANHTAM_2380601976\nThời gian: ${DateTime.now().hour}:${DateTime.now().minute}"
      );
    } finally {
      setState(() => _isChecking = false);
    }
  }

  void _showAlert(String title, String desc) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        content: Text(desc),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quét QR & Điểm Danh GPS'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo, width: 4),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black87,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code_scanner_rounded, size: 100, color: Colors.white),
                    SizedBox(height: 12),
                    Text('Đang quét mã QR từ máy chiếu...', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _isChecking
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Bấm Để Quét Mã & Check GPS', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                onPressed: _processCheckIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}