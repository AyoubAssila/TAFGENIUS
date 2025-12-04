import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../ViewModel/logs_vm.dart';
import 'package:tafgeniusmobile/main.dart'; // AdminTechniqueLayout

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LogsVM()..fetchLogs(), // récupérer les logs depuis DB
      child: const AdminTechniqueLayout(
        child: LogsContent(),
      ),
    );
  }
}

class LogsContent extends StatelessWidget {
  const LogsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LogsVM>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text(
            "Activity Logs",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: vm.filteredLogs.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: vm.filteredLogs.length,
            itemBuilder: (context, index) {
              final log = vm.filteredLogs[index];
              return ListTile(
                leading: Text(DateFormat("yyyy-MM-dd HH:mm").format(log.timestamp),
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
                title: Text("${log.type} — ${log.details}"),
                subtitle: Text("Course: ${log.courseId} • Lesson: ${log.lessonId}"),
              );
            },
          ),
        ),
      ],
    );
  }
}
