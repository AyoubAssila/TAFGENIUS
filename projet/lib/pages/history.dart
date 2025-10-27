// history_page.dart
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  final String initialTab;
  const HistoryPage({super.key, this.initialTab = 'Courses'});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late String _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ["Courses", "Quizzes", "Certificates", "Payments"];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("History",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: tabs.map((tab) {
              final isSelected = _selectedTab == tab;
              return ChoiceChip(
                label: Text(tab),
                selected: isSelected,
                selectedColor: Colors.blue[700],
                onSelected: (_) => setState(() => _selectedTab = tab),
                labelStyle:
                TextStyle(color: isSelected ? Colors.white : Colors.black),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 'Courses':
        return _buildCourses();
      case 'Quizzes':
        return _buildQuizzes();
      case 'Certificates':
        return _buildCertificates();
      case 'Payments':
        return _buildPayments();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCourses() {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.book, color: Colors.blue),
          title: Text("UI/UX Design"),
          subtitle: Text("12 lessons"),
        ),
        ListTile(
          leading: Icon(Icons.book, color: Colors.blue),
          title: Text("Python Programming"),
          subtitle: Text("10 lessons"),
        ),
      ],
    );
  }

  Widget _buildQuizzes() {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text("Python Basics Quiz"),
          subtitle: Text("Score: 85%"),
        ),
        ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text("UI/UX Principles"),
          subtitle: Text("Score: 90%"),
        ),
      ],
    );
  }

  Widget _buildCertificates() {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.emoji_events, color: Colors.amber),
          title: Text("UI/UX Design Certificate"),
          subtitle: Text("Issued: May 2024"),
        ),
        ListTile(
          leading: Icon(Icons.emoji_events, color: Colors.amber),
          title: Text("Python Programming Certificate"),
          subtitle: Text("Issued: June 2024"),
        ),
      ],
    );
  }

  Widget _buildPayments() {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.receipt_long, color: Colors.blue),
          title: Text("Invoice #12345"),
          subtitle: Text("Amount: 40 TND | Date: May 10, 2024"),
        ),
        ListTile(
          leading: Icon(Icons.receipt_long, color: Colors.blue),
          title: Text("Invoice #12346"),
          subtitle: Text("Amount: 50 TND | Date: June 2, 2024"),
        ),
      ],
    );
  }
}
