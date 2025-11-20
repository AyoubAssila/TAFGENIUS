import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../viewmodels/payments_viewmodel.dart';
import '../models/payment.dart';
import '../widgets/info_row.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PaymentsViewModel>(context);
    final grouped = vm.groupedPayments;
    final dates = grouped.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: vm.refresh,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: dates.length,
          itemBuilder: (ctx, index) {
            final dateKey = dates[index];
            final list = grouped[dateKey]!;
            final formattedDate = DateFormat('EEEE, dd MMM yyyy')
                .format(DateTime.parse(dateKey));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index != 0) const SizedBox(height: 12),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                ...list.map((p) => _PaymentCard(payment: p)).toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final Payment payment;

  const _PaymentCard({required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text('${payment.user} — ${payment.course}'),
        subtitle: Text(
          '${DateFormat('HH:mm').format(payment.date)} · ${payment.method}',
        ),
        trailing: Text(
          '${payment.amount.toStringAsFixed(2)} TND',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () => _showPaymentDetails(context),
      ),
    );
  }

  void _showPaymentDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Transaction ${payment.id}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoRow(label: 'User', value: payment.user),
            InfoRow(label: 'Course', value: payment.course),
            InfoRow(
              label: 'Amount',
              value: '${payment.amount.toStringAsFixed(2)} TND',
            ),
            InfoRow(label: 'Date', value: payment.formattedDate),
            InfoRow(label: 'Method', value: payment.method),
            InfoRow(label: 'Reference', value: payment.reference),
            InfoRow(
              label: 'Notes',
              value: payment.notes.isEmpty ? '-' : payment.notes,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
