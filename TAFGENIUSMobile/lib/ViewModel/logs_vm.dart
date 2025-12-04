import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../Model/logs.dart';

class LogsVM extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Logs> logs = [];
  String filter = "";
  String selectedDate = "";

  DocumentSnapshot? _lastDoc;
  bool _hasMore = true;
  bool _isLoading = false;
  static const int pageSize = 20;

  LogsVM() {
    fetchLogs();
  }

  Future<void> fetchLogs() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('activity')
          .orderBy('timestamp', descending: true)
          .limit(pageSize)
          .get();

      logs = snapshot.docs.map((d) => Logs.fromFirestore(d)).toList();
      _lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
      _hasMore = snapshot.docs.length == pageSize;
      notifyListeners();
    } catch (e) {
      debugPrint("fetchLogs error: $e");
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoading) return;
    if (_lastDoc == null) {
      await fetchLogs();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('activity')
          .orderBy('timestamp', descending: true)
          .startAfterDocument(_lastDoc!)
          .limit(pageSize)
          .get();

      final moreLogs = snapshot.docs.map((d) => Logs.fromFirestore(d)).toList();
      logs.addAll(moreLogs);
      _lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : _lastDoc;
      _hasMore = snapshot.docs.length == pageSize;
      notifyListeners();
    } catch (e) {
      debugPrint("loadMore error: $e");
    } finally {
      _isLoading = false;
    }
  }

  List<Logs> get filteredLogs {
    final q = filter.toLowerCase().trim();
    return logs.where((log) {
      final matchText = log.details.toLowerCase().contains(q) ||
          log.type.toLowerCase().contains(q) ||
          log.courseId.toLowerCase().contains(q) ||
          log.lessonId.toLowerCase().contains(q) ||
          log.userId.toLowerCase().contains(q);

      if (selectedDate.isEmpty) return matchText;

      final dateString = DateFormat("yyyy-MM-dd").format(log.timestamp);
      return matchText && dateString == selectedDate;
    }).toList();
  }

  void updateFilter(String value) {
    filter = value;
    notifyListeners();
  }

  void pickDate(DateTime picked) {
    selectedDate = DateFormat("yyyy-MM-dd").format(picked);
    notifyListeners();
  }
}
