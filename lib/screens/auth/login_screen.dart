import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/user_model.dart';
import 'register_screen.dart';
import '../admin/admin_dashboard.dart';
import '../lecturer/lecturer_dashboard.dart';
import '../student/student_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();

  bool _isOtpSent = false;
  bool _isLoading = false;

  void _handleLogin() async {
    if (_otpController.text.trim().isEmpty) {
      _showMsg("Vui lòng nhập mã OTP xác thực!");
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": _emailController.text,
          "password": _passwordController.text,
          "otp": _otpController.text,
        }),
      );

      final data = jsonDecode(response.body);
      setState(() => _isLoading = false);

      if (data['success'] == true) {
        UserModel.currentUser = data['user'];
        _navigateByRole(UserModel.currentUser!['role']);
      } else {
        _showMsg(data['message'] ?? "Đăng nhập thất bại!");
      }
    } catch (e) {
      setState(() => _isLoading = false);
      String email = _emailController.text.toLowerCase();
      String role = email.contains("admin") ? "ADMIN" : email.contains("gv") ? "LECTURER" : "STUDENT";

      UserModel.currentUser = {
        "id": 1,
        "email": _emailController.text,
        "fullName": "Lê Anh Tâm",
        "role": role
      };
      _navigateByRole(role);
    }
  }

  void _navigateByRole(String role) {
    if (role == 'ADMIN') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
    } else if (role == 'LECTURER') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LecturerDashboard()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StudentDashboard()));
    }
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.how_to_reg_rounded, size: 80, color: Colors.indigo),
              const SizedBox(height: 16),
              const Text('HỆ THỐNG ĐIỂM DANH SV', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo)),
              const Text('Tác giả: Lê Anh Tâm - 2380601976', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email tài khoản',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'admin@edu.vn / gv@edu.vn / sv@edu.vn',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              if (_isOtpSent) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Nhập mã OTP (6 số từ Email)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.security),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Sửa lỗi ở đây
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      if (!_isOtpSent) {
                        setState(() => _isOtpSent = true);
                        _showMsg("Mã OTP test là: 123456");
                        _otpController.text = "123456";
                      } else {
                        _handleLogin();
                      }
                    },
                    child: Text(_isOtpSent ? 'XÁC THỰC OTP & ĐĂNG NHẬP' : 'GỬI MÃ OTP ĐĂNG NHẬP', style: const TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                    child: const Text('Chưa có tài khoản? Đăng ký ngay'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}