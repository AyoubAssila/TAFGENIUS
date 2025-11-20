import 'package:intl/intl.dart';

class Payment {
  final String id;
  final String user;
  final double amount;
  final String course;
  final DateTime date;
  final String method;
  final String reference;
  final String notes;

  Payment({
    required this.id,
    required this.user,
    required this.amount,
    required this.course,
    required this.date,
    required this.method,
    required this.reference,
    required this.notes,
  });

  String get formattedDate =>
      DateFormat('yyyy-MM-dd – HH:mm').format(date);

  String get dateKey =>
      DateFormat('yyyy-MM-dd').format(date);
}
