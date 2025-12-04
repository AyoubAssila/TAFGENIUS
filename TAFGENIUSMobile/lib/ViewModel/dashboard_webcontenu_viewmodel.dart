import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/course_model.dart';
import '../Model/lesson_model.dart';
import '../Model/live_session_model.dart';
import '../Model/forum_thread_model.dart';

class DashboardViewModel extends ChangeNotifier {
  String _activeTab = 'dashboard';

  final List<CourseModel> _courses = [];
  final List<LiveSession> _liveSessions = [];
  final List<ForumThread> _forumThreads = [];
  ForumThread? _selectedThread;

  bool _showNewCourseModal = false;
  bool _showNewLiveModal = false;
  bool _showRepliesModal = false;

  Map<String, dynamic> _newCourse = {
    'title': '',
    'category': '',
    'description': '',
    'price': 0.0,
    'teacherId': '',
    'icon': '',
  };

  Map<String, dynamic> _newLive = {
    'title': '',
    'datetime': null, // DateTime
    'description': ''
  };

  String _newReply = '';
  String? _editingCourseId;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ---------- Getters ----------
  String get activeTab => _activeTab;
  List<CourseModel> get courses => _courses;
  List<LiveSession> get liveSessions => _liveSessions;
  List<ForumThread> get forumThreads => _forumThreads;
  ForumThread? get selectedThread => _selectedThread;
  bool get showNewCourseModal => _showNewCourseModal;
  bool get showNewLiveModal => _showNewLiveModal;
  bool get showRepliesModal => _showRepliesModal;
  Map<String, dynamic> get newCourse => _newCourse;
  Map<String, dynamic> get newLive => _newLive;
  String get newReply => _newReply;
  String? get editingCourseId => _editingCourseId;

  // ---------- UI Methods ----------
  void setActiveTab(String tab) {
    _activeTab = tab;
    notifyListeners();
  }

  void setShowNewCourseModal(bool show) {
    _showNewCourseModal = show;
    if (!show) {
      _newCourse = {
        'title': '',
        'category': '',
        'description': '',
        'price': 0.0,
        'teacherId': '',
        'icon': '',
      };
      _editingCourseId = null;
    }
    notifyListeners();
  }

  void setShowNewLiveModal(bool show) {
    _showNewLiveModal = show;
    if (!show) _newLive = {'title': '', 'datetime': null, 'description': ''};
    notifyListeners();
  }

  void setShowRepliesModal(bool show, [ForumThread? thread]) {
    _showRepliesModal = show;
    _selectedThread = thread;
    if (!show) _newReply = '';
    notifyListeners();
  }

  void updateNewCourse(String field, dynamic value) {
    _newCourse[field] = value;
    notifyListeners();
  }

  void updateNewLive(String field, dynamic value) {
    _newLive[field] = value;
    notifyListeners();
  }

  void updateNewReply(String content) {
    _newReply = content;
    notifyListeners();
  }

  // ---------- Firestore Operations ----------
  Future<void> loadCourses() async {
    try {
      final snapshot =
      await _db.collection('courses').orderBy('createdAt', descending: true).get();
      _courses.clear();
      for (var doc in snapshot.docs) {
        _courses.add(CourseModel.fromMap(doc.data() as Map<String, dynamic>, doc.id));
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading courses: $e');
    }
  }

  Future<void> loadLiveSessions() async {
    try {
      final snapshot = await _db.collection('live_sessions').orderBy('schedule').get();
      _liveSessions.clear();
      for (var doc in snapshot.docs) {
        _liveSessions.add(LiveSession.fromMap(doc.data() as Map<String, dynamic>, doc.id));
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading live sessions: $e');
    }
  }

  Future<void> loadForumThreads() async {
    try {
      final snapshot =
      await _db.collection('forum_threads').orderBy('date', descending: true).get();
      _forumThreads.clear();
      for (var doc in snapshot.docs) {
        _forumThreads.add(ForumThread.fromMap(doc.data() as Map<String, dynamic>, doc.id));
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading forum threads: $e');
    }
  }

  Future<void> loadAllData() async {
    await Future.wait([loadCourses(), loadLiveSessions(), loadForumThreads()]);
  }

  Future<void> createCourse() async {
    if ((_newCourse['title'] ?? '').toString().isEmpty ||
        (_newCourse['category'] ?? '').toString().isEmpty) return;

    final now = DateTime.now();

    try {
      // Add course to Firestore
      final docRef = await _db.collection('courses').add({
        'title': _newCourse['title'],
        'description': _newCourse['description'],
        'teacherId': _newCourse['teacherId'],
        'category': _newCourse['category'],
        'price': (_newCourse['price'] ?? 0.0).toDouble(),
        'icon': _newCourse['icon'],
        'createdAt': now,
        'updatedAt': now,
        'modulesCount': 0,
      });

      // Create instance with Firestore ID
      final newCourse = CourseModel(
        id: docRef.id,
        title: _newCourse['title'] ?? '',
        description: _newCourse['description'] ?? '',
        teacherId: _newCourse['teacherId'] ?? '',
        category: _newCourse['category'] ?? '',
        price: (_newCourse['price'] ?? 0.0).toDouble(),
        icon: _newCourse['icon'] ?? '',
        createdAt: now,
        updatedAt: now,
        modulesCount: 0,
        lessons: [],
      );

      _courses.add(newCourse);
      setShowNewCourseModal(false);
    } catch (e) {
      debugPrint('Error creating course: $e');
    }
  }

  Future<void> createLiveSession() async {
    if ((_newLive['title'] ?? '').toString().isEmpty ||
        (_newLive['datetime'] ?? '').toString().isEmpty) return;

    final schedule = _newLive['datetime'] is DateTime
        ? _newLive['datetime'] as DateTime
        : DateTime.tryParse(_newLive['datetime'].toString()) ?? DateTime.now();

    try {
      // Add live session to Firestore
      final docRef = await _db.collection('live_sessions').add({
        'title': _newLive['title'],
        'schedule': schedule,
        'description': _newLive['description'] ?? '',
        'participants': 0,
        'isActive': false,
        'meetLink': null,
      });

      // Create instance with Firestore ID
      final newSession = LiveSession(
        id: docRef.id,
        title: _newLive['title'] ?? '',
        schedule: schedule,
        description: _newLive['description'] ?? '',
        participants: 0,
        isActive: false,
      );

      _liveSessions.add(newSession);
      setShowNewLiveModal(false);
    } catch (e) {
      debugPrint('Error creating live session: $e');
    }
  }

  Future<void> deleteCourse(String courseId) async {
    try {
      await _db.collection('courses').doc(courseId).delete();
      _courses.removeWhere((c) => c.id == courseId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting course: $e');
    }
  }

  Future<void> startLiveSession(String sessionId) async {
    final session = _liveSessions.firstWhere(
          (s) => s.id == sessionId,
      orElse: () => LiveSession(id: '', title: '', schedule: DateTime.now()),
    );

    if (session.id.isNotEmpty) {
      session.isActive = true;
      session.participants += 1;
      notifyListeners();

      try {
        await _db.collection('live_sessions').doc(sessionId).update({
          'isActive': true,
          'participants': session.participants,
        });
      } catch (e) {
        debugPrint('Failed to update live session in Firestore: $e');
      }
    }
  }

  Map<String, dynamic> getStats() {
    final totalStudents = _courses.fold(0, (sum, course) => sum + course.lessons.length);
    final totalCourses = _courses.length;
    final activeLiveSessions = _liveSessions.where((s) => s.isActive).length;
    final totalReplies = _forumThreads.fold(0, (sum, thread) => sum + (thread.repliesCount ?? 0));
    final totalThreads = _forumThreads.length;

    return {
      'totalStudents': totalStudents,
      'totalCourses': totalCourses,
      'activeLiveSessions': activeLiveSessions,
      'totalReplies': totalReplies,
      'totalThreads': totalThreads,
    };
  }
  // ---------- Analytics Data from Firestore ----------
  Map<String, dynamic> get analyticsData {
    // Students per month (based on course creation month)
    Map<String, int> studentsPerMonth = {
      "Jan": 0,
      "Feb": 0,
      "Mar": 0,
      "Apr": 0,
      "May": 0,
      "Jun": 0,
      "Jul": 0,
      "Aug": 0,
      "Sep": 0,
      "Oct": 0,
      "Nov": 0,
      "Dec": 0,
    };

    for (var course in _courses) {
      String month = _monthAbbr(course.createdAt.month);
      studentsPerMonth[month] = (studentsPerMonth[month] ?? 0) + course.lessons.length;
    }

    // Engagement per day of week (live sessions participants)
    Map<String, int> engagementPerDay = {
      "Mon": 0,
      "Tue": 0,
      "Wed": 0,
      "Thu": 0,
      "Fri": 0,
      "Sat": 0,
      "Sun": 0,
    };

    for (var session in _liveSessions) {
      String day = _dayAbbr(session.schedule.weekday);
      engagementPerDay[day] = (engagementPerDay[day] ?? 0) + session.participants;
    }

    // Course popularity (by number of lessons)
    Map<String, int> coursePopularity = {};
    for (var course in _courses) {
      coursePopularity[course.title] = course.lessons.length;
    }

    return {
      'students': {
        'labels': studentsPerMonth.keys.toList(),
        'values': studentsPerMonth.values.toList(),
      },
      'engagement': {
        'labels': engagementPerDay.keys.toList(),
        'values': engagementPerDay.values.toList(),
      },
      'courses': {
        'labels': coursePopularity.keys.toList(),
        'values': coursePopularity.values.toList(),
      }
    };
  }

// Helper functions
  String _monthAbbr(int month) {
    const months = [
      '', // index 0 dummy
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month];
  }

  String _dayAbbr(int weekday) {
    const days = [
      '', // index 0 dummy
      "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
    ];
    return days[weekday];
  }

}
