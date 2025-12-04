import 'package:flutter/material.dart';

class LogRow extends StatelessWidget {
  final String date;
  final String message;
  final String amount;
  final String status;

  const LogRow({
    super.key,
    required this.date,
    required this.message,
    required this.amount,
    required this.status,
  });

  Color _statusColor() {
    switch (status) {
      case "success":
        return Colors.green;
      case "failed":
        return Colors.red;
      case "warning":
        return Colors.orange;
      case "admin":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _statusIcon() {
    switch (status) {
      case "success":
        return Icons.check_circle;
      case "failed":
        return Icons.cancel;
      case "warning":
        return Icons.warning;
      case "admin":
        return Icons.admin_panel_settings;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_statusIcon(), color: _statusColor(), size: 28),
      title: Text(message, style: const TextStyle(fontSize: 16)),
      subtitle: Text(date, style: const TextStyle(color: Colors.black54)),
      trailing: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _statusColor(),
        ),
      ),
    );
  }
}
