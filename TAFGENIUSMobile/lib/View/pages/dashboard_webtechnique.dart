import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/dashboard_vm.dart';
import '../../Model/user_model.dart';
import 'stats_webtechnique.dart';
import 'package:tafgeniusmobile/main.dart'; // AdminTechniqueLayout

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardVM()..fetchUsers(), // récupère les données dès l'initialisation
      child: const AdminTechniqueLayout(
        child: DashboardContent(),
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DashboardVM>(context);

    return Column(
      children: [
        Row(
          children: [
            Stats(
              title: "Users",
              value: vm.totalUsers.toString(),
              icon: Icons.people,
            ),
          ],
        ),
        const SizedBox(height: 20),

        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Latest Registered Users",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: vm.users.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text("Name")),
                          DataColumn(label: Text("Email")),
                          DataColumn(label: Text("Date Joined")),
                        ],
                        rows: vm.users.map((UserModel user) {
                          return DataRow(cells: [
                            DataCell(Text(user.name)),
                            DataCell(Text(user.email)),
                            DataCell(Text("${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}")),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
