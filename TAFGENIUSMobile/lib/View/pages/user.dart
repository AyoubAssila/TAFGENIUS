import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/user_vm.dart';
import 'package:tafgeniusmobile/main.dart'; // AdminTechniqueLayout

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UsersVM()..fetchUsers(), // récupère les users depuis la DB
      child: const AdminTechniqueLayout(
        child: UsersContent(),
      ),
    );
  }
}

class UsersContent extends StatelessWidget {
  const UsersContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UsersVM>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text(
            "User Management",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 400,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search...",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
            onChanged: vm.updateSearch,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Photo")),
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Email")),
                DataColumn(label: Text("Role")),
                DataColumn(label: Text("Date Joined")),
                DataColumn(label: Text("Actions")),
              ],
              rows: vm.filteredUsers.map((user) => DataRow(cells: [
                DataCell(CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.person_outline, color: Colors.blue),
                )),
                DataCell(Text(user.name)),
                DataCell(Text(user.email)),
                DataCell(Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: _getRoleColor(user.role),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(user.role,
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                )),
                DataCell(Text("${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}")),
                DataCell(Row(
                  children: [
                    IconButton(icon: const Icon(Icons.edit, color: Colors.blue, size: 20), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () => vm.deleteUser(user)),
                  ],
                )),
              ])).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'student':
        return Colors.green;
      case 'content_webmaster':
        return Colors.blue;
      case 'technical_webmaster':
        return Colors.orange;
      case 'commercial':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
