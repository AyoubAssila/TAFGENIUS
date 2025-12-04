import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/payments_viewmodel.dart';
import '../../Model/payment_model.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentsViewModel(),
      child: Consumer<PaymentsViewModel>(
        builder: (context, vm, _) {
          final grouped = vm.groupedPayments;
          final dates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

          return Scaffold(
            body: RefreshIndicator(
              onRefresh: vm.refresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: dates.length,
                itemBuilder: (ctx, index) {
                  final dateKey = dates[index];
                  final list = grouped[dateKey]!;
                  final formattedDate =
                  DateFormat('EEEE, dd MMM yyyy').format(DateTime.parse(dateKey));

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
        },
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final PaymentModel payment;

  const _PaymentCard({required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.payment)),
        title: Text('Transaction ${payment.id}'),
        subtitle: Text(
            '${DateFormat('HH:mm').format(payment.date)} · ${payment.method}'),
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
            _infoRow('Amount', '${payment.amount.toStringAsFixed(2)} TND'),
            _infoRow('Date', DateFormat('dd/MM/yyyy HH:mm').format(payment.date)),
            _infoRow('Method', payment.method),
            _infoRow('Status', payment.status),
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

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
