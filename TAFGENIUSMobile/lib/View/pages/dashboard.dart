import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/dashboard_viewmodel.dart';
import '../../Model/user_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    // Charge les stats après le premier build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Provider.of<UserModel>(context, listen: false);
      if (user.id.isNotEmpty) {
        Provider.of<DashboardViewModel>(context, listen: false)
            .loadDashboard(user.id);
      } else {
        // Si pas d'utilisateur, on peut gérer un fallback
        debugPrint("Utilisateur non connecté ou ID vide");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DashboardViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(
                  fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // --- STATS CARDS ---
            Row(
              children: [
                _statCard("Cours", vm.coursesCount, Colors.blue),
                const SizedBox(width: 16),
                _statCard("Quizzes", vm.quizzesCount, Colors.green),
                const SizedBox(width: 16),
                _statCard("Certificats", vm.certificatesCount, Colors.purple),
              ],
            ),

            const SizedBox(height: 40),
            const Text(
              "Activité de la semaine",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // --- WEEKLY BAR GRAPH ---
            SizedBox(
              height: 220,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: vm.weeklyActivity.entries.map((day) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: day.value * 20.0,
                          width: 22,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(day.key),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, int value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withOpacity(.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              "$value",
              style: const TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
