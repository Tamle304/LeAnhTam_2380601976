import 'package:flutter/material.dart';

class FaceAuthScreen extends StatelessWidget {
  const FaceAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Xác Thực Khuôn Mặt (Face ID)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 4),
                borderRadius: BorderRadius.circular(110),
              ),
              child: const Icon(Icons.face_rounded, size: 150, color: Colors.green),
            ),
            const SizedBox(height: 24),
            const Text('Đang quét khuôn mặt sinh viên...', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Xác thực Face ID thành công! Sinh viên: Lê Anh Tâm")));
                Navigator.pop(context);
              },
              child: const Text('XÁC NHẬN KHUÔN MẶT'),
            )
          ],
        ),
      ),
    );
  }
}