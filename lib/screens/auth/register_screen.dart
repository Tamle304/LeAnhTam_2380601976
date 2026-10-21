import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  String _role = 'STUDENT';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng Ký Tài Khoản Mới')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Họ và Tên')),
            const SizedBox(height: 12),
            TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email đăng ký')),
            const SizedBox(height: 12),
            TextField(controller: _passCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Mật khẩu')),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _role,
              decoration: const InputDecoration(labelText: 'Vai trò (Role)'),
              items: const [
                DropdownMenuItem(value: 'STUDENT', child: Text('Sinh viên')),
                DropdownMenuItem(value: 'LECTURER', child: Text('Giảng viên')),
                DropdownMenuItem(value: 'ADMIN', child: Text('Quản trị viên (Admin)')),
              ],
              onChanged: (val) => setState(() => _role = val!),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Đăng ký thành công! Vui lòng quay lại Đăng nhập.")),
                );
                Navigator.pop(context);
              },
              child: const Text('ĐĂNG KÝ TÀI KHOẢN'),
            )
          ],
        ),
      ),
    );
  }
}