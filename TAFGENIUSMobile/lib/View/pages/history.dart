import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/history_viewmodel.dart';
import '../../Model/course_model.dart';
import '../../Model/quizz_model.dart';
import '../../Model/certificate_model.dart';
import '../../Model/payment_model.dart';

class HistoryView extends StatelessWidget {
  final String userId;
  const HistoryView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = HistoryViewModel();
        vm.loadAllHistory(userId);
        return vm;
      },
      child: Consumer<HistoryViewModel>(
        builder: (context, vm, _) {
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("History"),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: "Courses"),
                    Tab(text: "Quizzes"),
                    Tab(text: "Certificates"),
                    Tab(text: "Payments"),
                  ],
                ),
              ),
              body: vm.courses.isEmpty &&
                  vm.quizzes.isEmpty &&
                  vm.certificates.isEmpty &&
                  vm.payments.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                children: [
                  buildCoursesTab(vm.courses),
                  buildQuizzesTab(vm.quizzes),
                  buildCertificatesTab(vm.certificates),
                  buildPaymentsTab(vm.payments),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------- Onglets ----------
  Widget buildCoursesTab(List<CourseModel> courses) {
    if (courses.isEmpty) return const Center(child: Text("No courses found."));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final c = courses[index];
        final progressPercent = c.modulesCount.clamp(0, 100);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: c.icon.isNotEmpty
                ? Image.asset(c.icon, width: 40, height: 40)
                : const Icon(Icons.book),
            title: Text(c.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Progress: $progressPercent%"),
          ),
        );
      },
    );
  }

  Widget buildQuizzesTab(List<QuizModel> quizzes) {
    if (quizzes.isEmpty) return const Center(child: Text("No quizzes found."));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        final q = quizzes[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(q.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Score: ${q.scoreFinal}%"),
          ),
        );
      },
    );
  }

  Widget buildCertificatesTab(List<CertificateModel> certificates) {
    if (certificates.isEmpty) return const Center(child: Text("No certificates found."));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: certificates.length,
      itemBuilder: (context, index) {
        final c = certificates[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(c.nomCours, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Issued: ${c.dateEmission.toLocal().toShortDateString()}"),
          ),
        );
      },
    );
  }

  Widget buildPaymentsTab(List<PaymentModel> payments) {
    if (payments.isEmpty) return const Center(child: Text("No payments found."));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: payments.length,
      itemBuilder: (context, index) {
        final p = payments[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text("Invoice ${p.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${p.amount} — ${p.date.toLocal().toShortDateString()}"),
          ),
        );
      },
    );
  }
}

// ---------- Extension pour afficher la date ----------
extension DateTimeExtension on DateTime {
  String toShortDateString() {
    return "${this.day}/${this.month}/${this.year}";
  }
}
