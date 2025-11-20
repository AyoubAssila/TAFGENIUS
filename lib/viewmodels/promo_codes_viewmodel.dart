import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../models/promo_code.dart';

class PromoCodesViewModel extends ChangeNotifier {
  List<PromoCode> _codes = [];
  bool loading = true;

  List<PromoCode> get codes => _codes;

  PromoCodesViewModel() {
    loadCodes();
  }

  Future<File> get _localFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/promo_codes.json');
  }

  // Load existing or seed demo data
  Future<void> loadCodes() async {
    loading = true;
    notifyListeners();

    try {
      final file = await _localFile;

      if (await file.exists()) {
        final data = jsonDecode(await file.readAsString()) as List<dynamic>;
        _codes = data.map((e) => PromoCode.fromJson(e)).toList();
      } else {
        _codes = [
          PromoCode(
            id: _uid(),
            code: 'WELCOME10',
            discount: 10,
            startDate: DateTime.now().subtract(const Duration(days: 60)),
            endDate: DateTime.now().add(const Duration(days: 30)),
            usageCount: 120,
          ),
          PromoCode(
            id: _uid(),
            code: 'SUMMER25',
            discount: 25,
            startDate: DateTime.now().subtract(const Duration(days: 10)),
            endDate: DateTime.now().add(const Duration(days: 8)),
            usageCount: 34,
          ),
        ];

        await saveCodes();
      }
    } catch (_) {}

    loading = false;
    notifyListeners();
  }

  Future<void> saveCodes() async {
    try {
      final file = await _localFile;
      await file.writeAsString(jsonEncode(_codes.map((c) => c.toJson()).toList()));
    } catch (_) {}
  }

  String _uid() => DateTime.now().millisecondsSinceEpoch.toString();

  void addPromo(PromoCode c) {
    _codes.add(c);
    saveCodes();
    notifyListeners();
  }

  void updatePromo(PromoCode updated) {
    final i = _codes.indexWhere((x) => x.id == updated.id);
    if (i >= 0) _codes[i] = updated;
    saveCodes();
    notifyListeners();
  }

  void deletePromo(String id) {
    _codes.removeWhere((x) => x.id == id);
    saveCodes();
    notifyListeners();
  }

  void incrementUsage(PromoCode c) {
    c.usageCount += 1;
    saveCodes();
    notifyListeners();
  }
}
