import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<Map<String, String>> students = [
    {"id": "1", "name": "Lê Anh Tâm", "code": "2380601976", "class": "23DTH1"},
    {"id": "2", "name": "Nguyễn Văn A", "code": "2380600001", "class": "23DTH2"},
  ];

  void _addOrEditStudent({Map<String, String>? student}) {
    final nameCtrl = TextEditingController(text: student?['name'] ?? '');
    final codeCtrl = TextEditingController(text: student?['code'] ?? '');
    final classCtrl = TextEditingController(text: student?['class'] ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(student == null ? 'Thêm Sinh Viên Mới' : 'Sửa Thông Tin Sinh Viên'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Họ tên')),
            TextField(controller: codeCtrl, decoration: const InputDecoration(labelText: 'Mã SV')),
            TextField(controller: classCtrl, decoration: const InputDecoration(labelText: 'Lớp')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (student == null) {
                  students.add({
                    "id": DateTime.now().millisecondsSinceEpoch.toString(),
                    "name": nameCtrl.text,
                    "code": codeCtrl.text,
                    "class": classCtrl.text,
                  });
                } else {
                  student['name'] = nameCtrl.text;
                  student['code'] = codeCtrl.text;
                  student['class'] = classCtrl.text;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          )
        ],
      ),
    );
  }

  void _deleteStudent(int index) {
    setState(() => students.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang Quản Trị - Admin Lê Anh Tâm'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditStudent(),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Quản lý danh sách Sinh Viên (CRUD - 4.5đ)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (_, index) {
                  final item = students[index];
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text("${item['name']} - ${item['code']}"),
                      subtitle: Text("Lớp: ${item['class']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _addOrEditStudent(student: item)),
                          IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteStudent(index)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}