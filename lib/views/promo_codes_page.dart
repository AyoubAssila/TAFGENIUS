import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/promo_code.dart';
import '../viewmodels/promo_codes_viewmodel.dart';
import '../widgets/info_row.dart';

class PromoCodesPage extends StatelessWidget {
  const PromoCodesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PromoCodesViewModel>(context);
    final formatter = DateFormat('dd/MM/yyyy');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () => _openCreateOrEdit(context),
        child: const Icon(Icons.add),
      ),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: vm.loadCodes,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Promo Codes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            ...vm.codes.map((c) {
              final expired = c.isExpired;

              return Opacity(
                opacity: expired ? 0.5 : 1,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.indigo, Colors.purpleAccent],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${c.discount.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      c.code,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${formatter.format(c.startDate)} → ${formatter.format(c.endDate)}',
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Uses',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${c.usageCount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _openDetail(context, c),
                    onLongPress: () => _confirmDelete(context, c),
                  ),
                ),
              );
            }),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // -----------------------
  // CREATE / EDIT POPUP
  // -----------------------
  void _openCreateOrEdit(BuildContext context, {PromoCode? edit}) async {
    final vm = Provider.of<PromoCodesViewModel>(context, listen: false);
    final formatter = DateFormat('dd/MM/yyyy');

    final codeCtrl = TextEditingController(text: edit?.code ?? '');
    final discountCtrl =
    TextEditingController(text: edit?.discount.toString() ?? '10');

    DateTime start = edit?.startDate ?? DateTime.now();
    DateTime end = edit?.endDate ?? DateTime.now().add(const Duration(days: 10));

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setStateDialog) {
          return AlertDialog(
            title: Text(edit == null ? 'Create Promo Code' : 'Edit Promo Code'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: codeCtrl,
                    decoration: const InputDecoration(labelText: 'Code'),
                  ),
                  TextField(
                    controller: discountCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Discount %'),
                  ),
                  const SizedBox(height: 10),

                  // Start Date
                  Row(
                    children: [
                      Expanded(
                        child: Text('Start: ${formatter.format(start)}'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final d = await showDatePicker(
                            context: ctx2,
                            initialDate: start,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (d != null) setStateDialog(() => start = d);
                        },
                        child: const Text('Pick'),
                      )
                    ],
                  ),

                  // End Date
                  Row(
                    children: [
                      Expanded(
                        child: Text('End: ${formatter.format(end)}'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final d = await showDatePicker(
                            context: ctx2,
                            initialDate: end,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (d != null) setStateDialog(() => end = d);
                        },
                        child: const Text('Pick'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(ctx),
              ),
              ElevatedButton(
                child: Text(edit == null ? 'Create' : 'Save'),
                onPressed: () {
                  final code = codeCtrl.text.trim();
                  final discount =
                      double.tryParse(discountCtrl.text.trim()) ?? 0;

                  if (code.isEmpty || discount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid input')),
                    );
                    return;
                  }

                  if (edit == null) {
                    vm.addPromo(
                      PromoCode(
                        id: DateTime.now()
                            .millisecondsSinceEpoch
                            .toString(),
                        code: code,
                        discount: discount,
                        startDate: start,
                        endDate: end,
                      ),
                    );
                  } else {
                    edit.code = code;
                    edit.discount = discount;
                    edit.startDate = start;
                    edit.endDate = end;
                    vm.updatePromo(edit);
                  }

                  Navigator.pop(ctx);
                },
              )
            ],
          );
        },
      ),
    );
  }

  // -----------------------
  // DELETE CONFIRMATION
  // -----------------------
  void _confirmDelete(BuildContext context, PromoCode c) async {
    final vm = Provider.of<PromoCodesViewModel>(context, listen: false);

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete'),
        content: Text('Delete promo code "${c.code}" ?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: const Text('Delete'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (ok == true) vm.deletePromo(c.id);
  }

  // -----------------------
  // DETAILS PAGE
  // -----------------------
  void _openDetail(BuildContext context, PromoCode promo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PromoDetailPage(promo: promo),
      ),
    );
  }
}

class PromoDetailPage extends StatelessWidget {
  final PromoCode promo;
  const PromoDetailPage({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PromoCodesViewModel>(context);
    final formatter = DateFormat('dd/MM/yyyy');
    final expired = promo.isExpired;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo Code Details'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // TOP CARD
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.indigo, Colors.purpleAccent],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${promo.discount.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            promo.code,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Period: ${formatter.format(promo.startDate)} → ${formatter.format(promo.endDate)}',
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Status: ${expired ? "Expired" : "Active"}',
                            style: TextStyle(
                              color: expired ? Colors.red : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // USAGE CARD
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      'Usage Count',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${promo.usageCount}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () => vm.incrementUsage(promo),
                      icon: const Icon(Icons.add),
                      label: const Text('Simulate Usage'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DELETE BUTTON
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                vm.deletePromo(promo.id);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete),
              label: const Text('Delete Code'),
            ),
          ],
        ),
      ),
    );
  }
}
