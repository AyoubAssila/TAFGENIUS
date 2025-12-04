import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Model/promotion_model.dart';
import '../../ViewModel/promotions_viewmodel.dart';
import '../components/info_row.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PromotionsViewModel(),
      child: Consumer<PromotionsViewModel>(
        builder: (context, vm, _) {
          final formatter = DateFormat('dd/MM/yyyy');

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.indigo,
              onPressed: () => _openCreate(context),
              child: const Icon(Icons.add),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  "Promotions",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),

                ...vm.promotions.map((p) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        p.occasion,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${formatter.format(p.validFrom)} → ${formatter.format(p.validUntil)}",
                      ),
                      trailing: Text("${p.discountPercent.toStringAsFixed(0)}%"),
                      onTap: () => _openDetail(context, p),
                      onLongPress: () => vm.deletePromotion(p.id),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openCreate(BuildContext context) {
    final vm = Provider.of<PromotionsViewModel>(context, listen: false);

    final codeCtrl = TextEditingController();
    final occasionCtrl = TextEditingController();
    final conditionCtrl = TextEditingController();
    final percentCtrl = TextEditingController(text: "10");
    final maxUsageCtrl = TextEditingController(text: "100");

    DateTime validFrom = DateTime.now();
    DateTime validUntil = DateTime.now().add(const Duration(days: 7));

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setStateDialog) {
          return AlertDialog(
            title: const Text("Create Promotion"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: codeCtrl,
                    decoration: const InputDecoration(labelText: 'Code'),
                  ),
                  TextField(
                    controller: occasionCtrl,
                    decoration: const InputDecoration(labelText: 'Occasion'),
                  ),
                  TextField(
                    controller: conditionCtrl,
                    decoration: const InputDecoration(labelText: 'Condition'),
                  ),
                  TextField(
                    controller: percentCtrl,
                    decoration: const InputDecoration(labelText: 'Discount %'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: maxUsageCtrl,
                    decoration: const InputDecoration(labelText: 'Max Usage'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                          child: Text("Start: ${DateFormat('dd/MM').format(validFrom)}")),
                      TextButton(
                        onPressed: () async {
                          final d = await showDatePicker(
                            context: ctx2,
                            initialDate: validFrom,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (d != null) setStateDialog(() => validFrom = d);
                        },
                        child: const Text("Pick"),
                      )
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Text("End: ${DateFormat('dd/MM').format(validUntil)}"),
                      ),
                      TextButton(
                        onPressed: () async {
                          final d = await showDatePicker(
                            context: ctx2,
                            initialDate: validUntil,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (d != null) setStateDialog(() => validUntil = d);
                        },
                        child: const Text("Pick"),
                      )
                    ],
                  ),
                ],
              ),
            ),

            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(ctx),
              ),
              ElevatedButton(
                child: const Text("Create"),
                onPressed: () {
                  if (codeCtrl.text.trim().isEmpty ||
                      occasionCtrl.text.trim().isEmpty) return;

                  vm.addPromotion(
                    PromotionModel(
                      id: "",
                      code: codeCtrl.text.trim(),
                      occasion: occasionCtrl.text.trim(),
                      condition: conditionCtrl.text.trim(),
                      discountPercent:
                      double.tryParse(percentCtrl.text) ?? 10,
                      validFrom: validFrom,
                      validUntil: validUntil,
                      maxUsage: int.tryParse(maxUsageCtrl.text) ?? 0,
                    ),
                  );

                  Navigator.pop(ctx);
                },
              )
            ],
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, PromotionModel p) {
    final formatter = DateFormat('dd/MM/yyyy');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(p.occasion),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoRow(
              label: "Code",
              value: p.code,
            ),
            InfoRow(
              label: "Period",
              value: "${formatter.format(p.validFrom)} → ${formatter.format(p.validUntil)}",
            ),
            InfoRow(
              label: "Discount",
              value: "${p.discountPercent.toStringAsFixed(0)}%",
            ),
            InfoRow(
              label: "Max Usage",
              value: "${p.maxUsage}",
            ),
            InfoRow(
              label: "Used",
              value: "${p.usageCount}",
            ),
            InfoRow(
              label: "Condition",
              value: p.condition,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
